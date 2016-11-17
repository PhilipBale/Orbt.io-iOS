//
//  OBTConversationViewController.h
//  Pods
//
//  Created by Philip Bale on 11/13/16.
//
//

#import "SLKTextViewController.h"
#import "Conversation.h"
#import "ORBTClient.h"

@interface ORBTConversationViewController : SLKTextViewController<ORBTClientDelegate>

@property (nonatomic, strong) Conversation *conversation;

@end
