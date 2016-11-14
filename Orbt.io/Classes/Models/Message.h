//
//  Message.h
//  Pods
//
//  Created by Philip Bale on 11/14/16.
//
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *senderName;

+ (Message *)messageFromDictionary:(NSDictionary *)dictionary;

@end
