//
//  UserApi.h
//  Pods
//
//  Created by Philip Bale on 11/13/16.
//
//

#import <Foundation/Foundation.h>

@interface UserApi : NSObject

+ (void)checkCredentialsForId:(NSString *)_id completion:(void (^)(BOOL success))completion;

@end
