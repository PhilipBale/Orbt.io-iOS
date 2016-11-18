//
//  OBTConversationViewController.m
//  Pods
//
//  Created by Philip Bale on 11/13/16.
//
//

#import "ORBTConversationViewController.h"
#import "MessageCell.h"
#import "Message.h"
#import "ConversationApi.h"

@interface ORBTConversationViewController ()

@property (nonatomic) UIView *spinnerView;
@property (nonatomic) UIActivityIndicatorView *spinner;


@end


@implementation ORBTConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:[MessageCell reuseId]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:50.0];
    self.inverted = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[ORBTClient sharedClient] setOrbtConversationDelegate:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showSpinner];
    });
    
    [ConversationApi loadMessagesForConversation:[[self conversation] _id] completion:^(BOOL success, NSArray<Message *> *messages) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideSpinner];
                [self.conversation setMessages:messages];
                [self.tableView reloadData];
                
            });
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageCell reuseId]];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MessageCell reuseId]];
    }
    Message *message = [[self.conversation messages] objectAtIndex:indexPath.row];
    
    [cell.messageTextLabel setText:[message text]];
    [cell.nameLabel setText:[message senderFirstName]];
    
    
    cell.transform = self.tableView.transform;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self conversation] messages] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)didPressRightButton:(id)sender
{
    NSString *text = [self.textView.text copy];
    NSLog(@"Sending message: %@", text);
    
    [ConversationApi sendMessage:text conversation:self.conversation._id completion:^(BOOL success, Message *message) {
        if (success) {
            [self.conversation.messages insertObject:message atIndex:0];
            [self.conversation setLastMessage:message];
            
            // Move conversation to front
            [[[ORBTClient sharedClient] conversations] removeObject:self.conversation];
            [[[ORBTClient sharedClient] conversations] insertObject:self.conversation atIndex:0];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [super didPressRightButton:sender];
            });
        }
        
    }];
}

- (void)newMessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)showSpinner {
    self.spinnerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.center = self.spinnerView.center;
    
    [self.spinnerView addSubview:self.spinner];
    [self.view addSubview:self.spinnerView];
    
    __weak ORBTConversationViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.spinner startAnimating];
    });
}

- (void)hideSpinner {
    if (self.spinner != nil) {
        __weak ORBTConversationViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.spinner stopAnimating];
            [weakSelf.spinnerView removeFromSuperview];
            weakSelf.spinner = nil;
            weakSelf.spinnerView = nil;
        });
    }
}


@end
