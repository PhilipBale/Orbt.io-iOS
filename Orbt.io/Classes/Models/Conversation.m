//
//  Conversation.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "Conversation.h"

@implementation Conversation

- (BOOL)isEqual:(id)object
{
    if (![object isMemberOfClass:[Conversation class]]) return NO;
    
    Conversation *target = (Conversation *)object;
    
    return [self _id] == [target _id];
}

+ (Conversation *)conversationFromDictionary:(NSDictionary *)dictionary
{
    Conversation *conversation = [[Conversation alloc] init];
    conversation._id = [dictionary objectForKey:@"_id"];
    
    return conversation;
}

@end
