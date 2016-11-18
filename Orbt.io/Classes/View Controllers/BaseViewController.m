//
//  BaseViewController.m
//  Pods
//
//  Created by Philip Bale on 11/18/16.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic) UIView *spinnerView;
@property (nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSpinner {
    self.spinnerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.center = self.spinnerView.center;
    
    [self.spinnerView addSubview:self.spinner];
    [self.view addSubview:self.spinnerView];
    
    __weak BaseViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.spinner startAnimating];
    });
}

- (void)hideSpinner {
    if (self.spinner != nil) {
        __weak BaseViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.spinner stopAnimating];
            [weakSelf.spinnerView removeFromSuperview];
            weakSelf.spinner = nil;
            weakSelf.spinnerView = nil;
        });
    }
}
@end
