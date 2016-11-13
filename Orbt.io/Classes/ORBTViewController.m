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
        [self configureView];
    });
}

- (void)configureView
{
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
}

@end
