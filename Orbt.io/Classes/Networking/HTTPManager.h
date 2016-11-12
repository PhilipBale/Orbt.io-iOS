//
//  HTTPManager.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>

#import "AFNetworking/AFNetworking.h"
#import "HTTPPaths.h"


@interface HTTPManager : AFHTTPRequestOperationManager

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)setRequestHeadersForAppId:(NSString *)appId uuid:(NSString *)uuid identityToken:(NSString *)identityToken;

@end
