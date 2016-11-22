//
//  ORBTInboxViewController.m
//  Pods
//
//  Created by Philip Bale on 11/11/16.
//
//

#import "ORBTInboxViewController.h"
#import "ConversationCell.h"
#import "ORBTClient.h"
#import "ORBTConversationViewController.h"
#import "NSDate+DateTools.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ORBTInboxViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ORBTInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[ORBTClient sharedClient] setOrbtInboxDelegate:self];


    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showSpinner];
        [self.tableView reloadData];
        
        [[ORBTClient sharedClient] loadConversationsWithCompletion:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideSpinner];
                    [self.tableView reloadData];
                });
            }
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (UITableViewCell *) tableView: (UITableView *)tableVw cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    ConversationCell *cell = [tableVw dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath: indexPath];
    Conversation *conversation = [[[ORBTClient sharedClient] conversations] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:[[conversation participants] componentsJoinedByString:@", "]];
    [cell.lastMessageLabel setText:[[conversation lastMessage] text]];
    [cell.dateLabel setText:[[[conversation lastMessage] timestamp] shortTimeAgoSinceNow]];
    
    if ([[conversation avatarUrl] length]) {
        [cell.avatarImageView setHidden:NO];
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[conversation avatarUrl]]];
    } else {
        // hide image
        [cell.avatarImageView setHidden:YES];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Conversation *conversation = [[[ORBTClient sharedClient] conversations] objectAtIndex:indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Messenger" bundle:[NSBundle bundleForClass:[ORBTInboxViewController class]]];
    ORBTConversationViewController *conversationVC = [sb instantiateViewControllerWithIdentifier:@"ConversationVC"];
    [conversationVC setConversation:conversation];
    
    [self.navigationController pushViewController:conversationVC animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger conversationCount = [[[ORBTClient sharedClient] conversations] count];
    [self.emptyConversationsLabel setHidden:(conversationCount > 0)];
    
    return conversationCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ConversationCell height];
}

- (void)newMessage
{
    [self newConversation];
}

- (void)newConversation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


@end
