//
//  Message.m
//  Pods
//
//  Created by Philip Bale on 11/14/16.
//
//

#import "Message.h"
#import "ORBTClient.h"

@implementation Message

+ (Message *)messageFromDictionary:(NSDictionary *)dictionary
{
    if (!dictionary) return nil;
    
    Message *message = [[Message alloc] init];
    message._id = [dictionary objectForKey:@"_id"];
    message.text = [dictionary objectForKey:@"text"];
    message.senderFirstName = [[dictionary objectForKey:@"sender"] objectForKey:@"firstName"];
    message.senderLastName = [[dictionary objectForKey:@"sender"] objectForKey:@"lastName"];
    message.timestamp = [ORBTClient parseServerDate:[dictionary objectForKey:@"time"]];
    
    if (![[message senderFirstName] length]) {
        message.senderFirstName = [[dictionary objectForKey:@"sender"] objectForKey:@"uuid"];
    }
    
    return message;
}

@end
