//
//  Conversation.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface Conversation : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSArray<NSString *> *participants;
@property (nonatomic, strong) NSMutableArray<Message *> *messages;
@property (nonatomic, strong) Message *lastMessage;

+ (Conversation *)conversationFromDictionary:(NSDictionary *)dictionary;

@end
