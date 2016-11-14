//
//  ConversationApi.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <Foundation/Foundation.h>
#import "HTTPManager.h"
#import "Conversation.h"

@interface ConversationApi : NSObject

+ (void)allConversationsWithCompletion:(void (^)(BOOL success, NSArray<Conversation *> *conversations))completion;
+ (void)loadMessagesForConversation:(NSString *)conversationId completion:(void (^)(BOOL success, NSArray<Message *> *messages))completion;

@end
