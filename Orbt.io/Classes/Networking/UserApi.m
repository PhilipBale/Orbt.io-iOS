//
//  UserApi.m
//  Pods
//
//  Created by Philip Bale on 11/13/16.
//
//

#import "UserApi.h"
#import "HTTPManager.h"

@implementation UserApi

+ (void)checkCredentialsForId:(NSString *)_id completion:(void (^)(BOOL success))completion
{
    [HTTPManager GET:kApiPathCheckCredentials parameters:nil success:^(NSDictionary *responseObject)
     {
         if (completion) completion(YES);
     } failure:^(NSError *error) {
         if (completion) completion(NO);
     }];
    
}

@end
