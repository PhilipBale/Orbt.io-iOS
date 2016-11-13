//
//  Conversation.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>

@interface Conversation : NSObject

@property (nonatomic, strong) NSString *_id;

+ (Conversation *)conversationFromDictionary:(NSDictionary *)dictionary;

@end
