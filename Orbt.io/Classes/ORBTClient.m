//
//  ORBTClient.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "ORBTClient.h"
#import "HTTPManager.h"

@interface ORBTClient ()


@property (nonatomic, strong) NSString *identityToken;

@end

@implementation ORBTClient


+ (ORBTClient *)sharedClient
{
    static dispatch_once_t pred;
    static ORBTClient *_sharedClient = nil;
    
    dispatch_once(&pred, ^{
        _sharedClient = [[self alloc] init];
        
        NSLog(@"[ORBTClient] Client initialized");
        
    });
    return _sharedClient;
}

+ (void)setAppId:(NSString *)appId
{
    [[self sharedClient] setAppId:appId];
    NSLog(@"[ORBTClient] Setting AppId to: %@", appId);
}

+ (void)connectWithUUID:(NSString *)uuid identityToken:(NSString *)token completion:(void (^)(BOOL))completion
{
    NSLog(@"[ORBTClient] Connecting to ORBT backend");
    [HTTPManager setRequestHeadersForAppId:[[self sharedClient] appId] uuid:uuid identityToken:token];
    
    if (completion) completion(NO);
}

@end
