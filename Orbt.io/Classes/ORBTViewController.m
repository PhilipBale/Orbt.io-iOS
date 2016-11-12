//
//  ORBTViewController.m
//  Pods
//
//  Created by Philip Bale on 11/11/16.
//
//

#import "ORBTViewController.h"
#import "ORBTInboxViewController.h"

@interface ORBTViewController ()

@property (nonatomic, strong) ORBTInboxViewController *inboxViewController;

@end

@implementation ORBTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Messenger" bundle:[NSBundle bundleForClass:[self class]]];
    self.inboxViewController = [sb instantiateViewControllerWithIdentifier:@"InboxVC"];
    [self.inboxViewController.view setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *navController = self.navigationController;
        if (!navController) {
            NSLog(@"No nav controller, creating one");
            navController = [[UINavigationController alloc] initWithRootViewController:self.inboxViewController];
            [navController setTitle:@"Messages"];
            [[navController.navigationBar topItem] setTitle:@"Messages"];
            [self presentViewController:navController animated:NO completion:nil];
            
        } else {
            [self addChildViewController:self.inboxViewController ];
            
            [self.view addSubview:self.inboxViewController.view];
            [self.inboxViewController didMoveToParentViewController:self];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
