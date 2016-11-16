//
//  ORBTClient.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>
#import "Conversation.h"

@interface ORBTClient : NSObject

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong, readonly) NSString *uuid;

@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, strong, readonly) NSMutableArray<Conversation *> *conversations;

+ (ORBTClient *)sharedClient;
+ (void)setAppId:(NSString *)appId;

+ (NSDate *)parseServerDate:(NSString *)date;

- (void)connectWithUUID:(NSString *)uuid identityToken:(NSString *)token completion:(void (^)(BOOL success))completion;
- (void)loadConversationsWithCompletion:(void (^)(BOOL))completion;

@end
