//
//  Message.m
//  Pods
//
//  Created by Philip Bale on 11/14/16.
//
//

#import "Message.h"

@implementation Message

+ (Message *)messageFromDictionary:(NSDictionary *)dictionary
{
    Message *message = [[Message alloc] init];
    message._id = [dictionary objectForKey:@"_id"];
    message.text = [dictionary objectForKey:@"text"];
    
    return message;
}

@end
