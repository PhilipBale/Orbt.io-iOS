//
//  HTTPManager.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "HTTPManager.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking/AFNetworking.h>
#include "TargetConditionals.h"

@implementation HTTPManager

#pragma mark + Singleton Methods

+ (HTTPManager *)sharedManager
{
    static dispatch_once_t pred;
    static HTTPManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] initWithBaseURL: [NSURL URLWithString:BASE_API_URL]];
        _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        NSLog(@"[ORBTHTTPManager] Using base URL: %@", BASE_API_URL);
        
    });
    return _sharedManager;
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self GET:URLString parameters:parameters success:success failure:failure attemptsLeft:kAPIAttempts];
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure attemptsLeft:(NSInteger)attemptsLeft
{
    [[HTTPManager sharedManager] GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL trueSuccess = [self wasSuccessfulGet:responseObject];
        if (success && trueSuccess)
        {
            success(responseObject);
        }
        else if (!trueSuccess)
        {
            if (failure)
            {
                NSLog(@"[ORBTHTTPManager] NOTICE: Successful HTTP GET but incorrect status code match");
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (attemptsLeft)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAPIAttemptDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self GET:URLString parameters:parameters success:success failure:failure attemptsLeft:attemptsLeft - 1];
            });
        } else if (failure)
        {
            NSLog(@"[ORBTHTTPManager] HTTP MANAGER FINISHED FAILING GET AFTER %d attempts with %f delays inbetween for path: %@", kAPIAttempts, kAPIAttemptDelay, URLString);
            failure(error);
        }
    }];
}
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self POST:URLString parameters:parameters success:success failure:failure attemptsLeft:kAPIAttempts];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure attemptsLeft:(NSInteger)attemptsLeft
{
    NSLog(@"[ORBTHTTPManager] Posting to url: %@, attempts left: %li", URLString, attemptsLeft);
    [[HTTPManager sharedManager] POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL trueSuccess = [self wasSuccessfulPost:responseObject];
        if (success && trueSuccess)
        {
            success(responseObject);
        }
        else if (!trueSuccess)
        {
            if (failure)
            {
                NSLog(@"[ORBTHTTPManager] NOTICE: Successful HTTP POST but incorrect status code match");
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (attemptsLeft)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAPIAttemptDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self POST:URLString parameters:parameters success:success failure:failure attemptsLeft:attemptsLeft - 1];
            });
        } else if (failure)
        {
            NSLog(@"[ORBTHTTPManager] HTTP MANAGER FINISHED FAILING POST AFTER %d attempts with %f delays inbetween for path: %@", kAPIAttempts, kAPIAttemptDelay, URLString);
            failure(error);
        }
    }];
}

+ (BOOL)wasSuccessfulGet:(id)responseObject
{
    NSDictionary *responseDict = responseObject;
    return [responseDict[@"status"] isEqualToString:@"ok"];
}

+ (BOOL)wasSuccessfulPost:(id)responseObject
{
    NSDictionary *responseDict = responseObject;
    return [responseDict[@"status"] isEqualToString:@"created"];
}

+ (void)setRequestHeadersForAppId:(NSString *)appId uuid:(NSString *)uuid identityToken:(NSString *)identityToken
{
    NSLog(@"[ORBTHTTPManager] AppId set to: %@, uuid: %@, and identity token: %@", appId, uuid, identityToken);
    [[[HTTPManager sharedManager] requestSerializer] setValue:appId forHTTPHeaderField:@"AppId"];
    [[[HTTPManager sharedManager] requestSerializer] setValue:uuid forHTTPHeaderField:@"UUID"];
    [[[HTTPManager sharedManager] requestSerializer] setValue:identityToken forHTTPHeaderField:@"UserToken"];
}


@end
