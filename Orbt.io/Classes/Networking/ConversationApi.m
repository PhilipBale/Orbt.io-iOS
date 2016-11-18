//
//  ConversationApi.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "ConversationApi.h"

@implementation ConversationApi

+ (void)allConversationsWithCompletion:(void (^)(BOOL success, NSArray<Conversation *> *conversations))completion
{
    [HTTPManager GET:kApiPathAllConversations parameters:nil success:^(NSDictionary *responseObject)
     {
         NSMutableArray *conversationObjects = [[NSMutableArray alloc] init];
         
         for (NSDictionary *conversationDictionary in responseObject)
         {
             Conversation *conversation =[Conversation conversationFromDictionary:conversationDictionary];
             if (conversation) [conversationObjects addObject:conversation];
         }
         
         conversationObjects = [[conversationObjects sortedArrayUsingComparator:
                            ^(id obj1, id obj2) {
                                Conversation *conversation1 = obj1;
                                Conversation *conversation2 = obj2;
                                return [[[conversation2 lastMessage] timestamp] compare:[[conversation1 lastMessage] timestamp]];
                            }] mutableCopy];

                                
         if (completion) completion(YES, conversationObjects);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

+ (void)loadMessagesForConversation:(NSString *)conversationId completion:(void (^)(BOOL success, NSArray<Message *> *messages))completion
{
    [HTTPManager GET:[NSString stringWithFormat:@"%@/%@/messages", kApiPathMessagesForConversation, conversationId] parameters:nil success:^(NSDictionary *responseObject)
     {
         NSMutableArray *messageObjects = [[NSMutableArray alloc] init];
         
         for (NSDictionary *messageDictionary in responseObject)
         {
             Message *message = [Message messageFromDictionary:messageDictionary];
             if (message) [messageObjects addObject:message];
         }
         
         messageObjects = [[messageObjects sortedArrayUsingComparator:
                            ^(id obj1, id obj2) {
                                Message *message1 = obj1;
                                Message *message2 = obj2;
                                return [[message2 timestamp] compare:[message1 timestamp]];
                            }] mutableCopy];
         if (completion) completion(YES, messageObjects);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

+ (void)sendMessage:(NSString *)text conversation:(NSString *)conversationId completion:(void (^)(BOOL success, Message *message))completion
{
    NSDictionary *params = @{@"conversation":conversationId, @"text":text};
    [HTTPManager POST:kApiPathSendMessage parameters:params success:^(NSDictionary *responseObject)
     {
         Message *message = [Message messageFromDictionary:responseObject];
         if (completion) completion(YES, message);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

@end
