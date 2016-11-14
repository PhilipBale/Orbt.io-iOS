//
//  OBTConversationViewController.m
//  Pods
//
//  Created by Philip Bale on 11/13/16.
//
//

#import "ORBTConversationViewController.h"
#import "ORBTClient.h"
#import "MessageCell.h"
#import "Message.h"
#import "ConversationApi.h"

@interface ORBTConversationViewController ()

@end


@implementation ORBTConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:[MessageCell reuseId]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:50.0];
    self.inverted = YES;
    
    [ConversationApi loadMessagesForConversation:[[self conversation] _id] completion:^(BOOL success, NSArray<Message *> *messages) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.tableView reloadData];
            } 
        });
    }];
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageCell reuseId] forIndexPath: indexPath];
    Message *message = [[self.conversation messages] objectAtIndex:indexPath.row];
    
    cell.textLabel = [message text];
    cell.nameLabel = [message senderName];
    
    cell.transform = self.tableView.transform;
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [[self.conversation messages] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
