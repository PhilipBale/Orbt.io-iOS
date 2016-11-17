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
@property(nonatomic, strong) NSString *conversationId;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *senderFirstName;
@property(nonatomic, strong) NSString *senderLastName;
@property(nonatomic, strong) NSDate *timestamp;

+ (Message *)messageFromDictionary:(NSDictionary *)dictionary;

@end
