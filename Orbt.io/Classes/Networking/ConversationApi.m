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

+ (void)loadMessagesForConversation:(NSString *)conversationId completion:(void (^)(BOOL success, NSArray<Message *> *messages))completion
{
    [HTTPManager GET:[NSString stringWithFormat:@"%@/%@/messages", kApiPathMessagesForConversation, conversationId] parameters:nil success:^(NSDictionary *responseObject)
     {
         NSMutableArray *messageObjects = [[NSMutableArray alloc] init];
         
         for (NSDictionary *messageDictionary in responseObject)
         {
             [messageObjects addObject:[Message messageFromDictionary:messageDictionary]];
         }
         if (completion) completion(YES, messageObjects);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

+ (void)sendMessage:(NSString *)text conversation:(NSString *)conversationId completion:(void (^)(BOOL success, Message *message))completion
{
    NSDictionary *params = @{@"conversation":conversationId, @"text":text};
    [HTTPManager POST:kApiPathSendMessage parameters:params success:^(NSDictionary *responseObject)
     {
         Message *message = [Message messageFromDictionary:responseObject];
         if (completion) completion(YES, message);
     } failure:^(NSError *error) {
         if (completion) completion(NO, nil);
     }];
}

@end
