//
//  ORBTClient.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "ORBTClient.h"
#import "HTTPManager.h"
#import "ConversationApi.h"
#import "UserApi.h"

@import SocketIO;

static NSString * const kOrbtBackendPath = @"http://backend.orbt.io";

@interface ORBTClient ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSString *identityToken;

@property (nonatomic, strong) SocketIOClient *socket;

@end

@implementation ORBTClient


+ (ORBTClient *)sharedClient
{
    static dispatch_once_t pred;
    static ORBTClient *_sharedClient = nil;
    
    dispatch_once(&pred, ^{
        _sharedClient = [[self alloc] init];
        [_sharedClient setDateFormatter:[[NSDateFormatter alloc] init]];
        [[_sharedClient dateFormatter] setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        NSLog(@"[ORBTClient] Client initialized");
        
    });
    return _sharedClient;
}

+ (void)setAppId:(NSString *)appId
{
    [[self sharedClient] setAppId:appId];
    NSLog(@"[ORBTClient] Setting AppId to: %@", appId);
}

- (void)connectWithUUID:(NSString *)uuid identityToken:(NSString *)token completion:(void (^)(BOOL))completion
{
    [self disconnect];
    NSLog(@"[ORBTClient] Connecting to ORBT backend");
    [HTTPManager setRequestHeadersForAppId:[self appId] uuid:uuid identityToken:token];
    
    [UserApi checkCredentialsForId:uuid completion:^(BOOL success) {
        _connected = success;
        _identityToken = token;
        _uuid = uuid;
        
        if (success)
        {
            NSLog(@"[ORBTClient] Succesful connection to ORBT backend");
            if (completion) completion(YES);
            [self setupSocketWithUUID:uuid identityToken:token];
        }
        else
        {
            NSLog(@"[ORBTClient] Failed connection to ORBT backend");
            if (completion) completion(NO);
        }
    }];
}

- (void)disconnect
{
    NSLog(@"[ORBTClient] Disconnecting any prior authenticated accounts");
    [self.socket disconnect];
    self.socket = nil;
    
    [HTTPManager setRequestHeadersForAppId:@"" uuid:@"" identityToken:@""];
    _connected = NO;
    _identityToken = nil;
    _uuid = nil;
}

- (void)setupSocketWithUUID:(NSString *)uuid identityToken:(NSString *)token
{
    SocketIOClient *socket = [[SocketIOClient alloc] initWithSocketURL:[NSURL URLWithString:kOrbtBackendPath] config:@{@"log": @NO, @"forcePolling": @YES, @"connectParams":@{@"uuid":uuid, @"appId":self.appId, @"userToken":token}}];
    
    [socket on:@"connect" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"[ORBTClientSocket] Connected");
    }];
    
    [socket on:@"authenticated" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"[ORBTClientSocket] Authenticated");
    }];
    
    [socket on:@"newMessage" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"[ORBTClientSocket] New message");
        NSDictionary *messageData = [[[data objectAtIndex:0] objectForKey:@"data"] objectForKey:@"message"];
        Message *message = [Message messageFromDictionary:messageData];
        
        Conversation *conversationRefreshed = nil;
        for (Conversation *conversation in self.conversations) {
            if ([[conversation _id] isEqualToString:[message conversationId]]) {
                [conversation setLastMessage:message];
                [conversation.messages insertObject:message atIndex:0];
                
                if ([self.orbtInboxDelegate respondsToSelector:@selector(newMessage)]) [self.orbtInboxDelegate newMessage];
                if ([self.orbtConversationDelegate respondsToSelector:@selector(newMessage)]) [self.orbtConversationDelegate newMessage];
                
                conversationRefreshed = conversation;
                
                break;
            }
        }
        
        if (conversationRefreshed) {
            [self.conversations removeObject:conversationRefreshed];
            [self.conversations insertObject:conversationRefreshed atIndex:0];
        }
        
    }];
    
    [socket on:@"newConversation" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"[ORBTClient] New conversation");
        NSDictionary *conversationData = [[[data objectAtIndex:0] objectForKey:@"data"] objectForKey:@"conversation"];
        Conversation *conversation = [Conversation conversationFromDictionary:conversationData];
        [self.conversations insertObject:conversation atIndex:0];
        
        if ([self.orbtInboxDelegate respondsToSelector:@selector(newConversation)]) [self.orbtInboxDelegate newConversation];
        if ([self.orbtConversationDelegate respondsToSelector:@selector(newConversation)]) [self.orbtConversationDelegate newConversation];
    }];
    
    [socket connect];
    
    self.socket = socket;
}

- (void)loadConversationsWithCompletion:(void (^)(BOOL))completion
{
    [ConversationApi allConversationsWithCompletion:^(BOOL success, NSArray<Conversation *> *conversations) {
        if (success) {
            _conversations = [[NSMutableArray alloc] initWithArray:conversations];
            if (completion) completion(YES);
        } else {
            if (completion) completion(NO);
        }
    }];
}

+ (NSDate *)parseServerDate:(NSString *)date
{
    return [[[self sharedClient] dateFormatter] dateFromString:date];
}

@end
