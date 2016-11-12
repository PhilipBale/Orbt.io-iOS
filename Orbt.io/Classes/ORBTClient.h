//
//  ORBTClient.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>

@interface ORBTClient : NSObject

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *uuid;

+ (ORBTClient *)sharedClient;

+ (void)setAppId:(NSString *)appId;
+ (void)connectWithUUID:(NSString*)uuid identityToken:(NSString *)token completion:(void (^)(BOOL success))completion;

@end
