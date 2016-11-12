//
//  ORBTInboxViewController.m
//  Pods
//
//  Created by Philip Bale on 11/11/16.
//
//

#import "ORBTInboxViewController.h"
#import "ConversationCell.h"

@interface ORBTInboxViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ORBTInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *) tableView: (UITableView *)tableVw cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    ConversationCell *cell = [tableVw dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath: indexPath];
    
    [cell.titleLabel setText:[NSString stringWithFormat:@"hey %li", indexPath.row]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ConversationCell height];
}

@end
