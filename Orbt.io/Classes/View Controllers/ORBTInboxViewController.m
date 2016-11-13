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

@interface ORBTInboxViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ORBTInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [[ORBTClient sharedClient] loadConversationsWithCompletion:^(BOOL success) {
           if (success) {
              [self.tableView reloadData];
           }
       }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *) tableView: (UITableView *)tableVw cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    ConversationCell *cell = [tableVw dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath: indexPath];
    Conversation *conversation = [[[ORBTClient sharedClient] conversations] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:[NSString stringWithFormat:@"hey %@", [conversation _id]]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ORBTClient sharedClient] conversations] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ConversationCell height];
}

@end
