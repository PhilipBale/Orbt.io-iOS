//
//  ORBTInboxViewController.h
//  Pods
//
//  Created by Philip Bale on 11/11/16.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ORBTClient.h"

@interface ORBTInboxViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, ORBTClientDelegate>

@property (weak, nonatomic) IBOutlet UILabel *emptyConversationsLabel;

@end
