//
//  ConversationApi.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "ConversationApi.h"

@implementation ConversationApi

+ (void)allConversationsWithCompletion:(void (^)(BOOL success, NSArray<Conversation *> *conversations))completion
{
    [HTTPManager GET:kApiPathAllConversations parameters:nil success:^(NSDictionary *responseObject)
     {
         NSMutableArray *conversationObjects = [[NSMutableArray alloc] init];
         
             for (NSDictionary *conversationDictionary in responseObject)
             {
                 [conversationObjects addObject:[Conversation conversationFromDictionary:conversationDictionary]];
             }          
         if (completion) completion(YES, conversationObjects);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

@end
