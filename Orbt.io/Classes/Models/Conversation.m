//
//  Conversation.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "Conversation.h"
#import "ORBTClient.h"

@implementation Conversation

- (BOOL)isEqual:(id)object
{
    if (![object isMemberOfClass:[Conversation class]]) return NO;
    
    Conversation *target = (Conversation *)object;
    
    return [self _id] == [target _id];
}

+ (Conversation *)conversationFromDictionary:(NSDictionary *)dictionary
{
    if (!dictionary) return nil;
    
    NSString *userUuid = [[ORBTClient sharedClient] uuid];
    
    Conversation *conversation = [[Conversation alloc] init];
    conversation._id = [dictionary objectForKey:@"_id"];
    conversation.lastMessage = [Message messageFromDictionary:[dictionary objectForKey:@"lastMessage"]];
    
    NSMutableArray<NSString *> *users = [[NSMutableArray alloc] init];
    for (NSDictionary *user in [dictionary objectForKey:@"users"]) {
        if ([[user objectForKey:@"uuid"] isEqualToString:userUuid]) continue;
        
        NSString *firstName = [user objectForKey:@"firstName"];
        if (![firstName length]) {
            firstName = [user objectForKey:@"uuid"];
        }
        
        [users addObject:firstName];
    }
    
    conversation.participants = users;
    conversation.messages = [[NSMutableArray alloc] init];
    
    return conversation;
}

@end
