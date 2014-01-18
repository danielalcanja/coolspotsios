//
//  CSWelcomeViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/18/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSWelcomeViewController.h"
#import "CSLoginViewController.h"

@interface CSWelcomeViewController ()

@end

@implementation CSWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect frame = self.view.bounds;
    
    UIImageView *imgAppLoading = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    imgAppLoading.frame = frame;
    [self.view addSubview:imgAppLoading];
    
    
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogin.frame = CGRectMake(frame.size.width/2-168/2, frame.size.height-54, 168,54);
    [buttonLogin setBackgroundImage:[UIImage imageNamed:@"btn-login-instagram"] forState:UIControlStateNormal];
    [buttonLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
}
-(IBAction)goLogin:(id)sender {
    
    CSLoginViewController *login = [[CSLoginViewController alloc] init];
    
    [self.navigationController pushViewController:login animated:YES];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

}
-(void)viewWillDisappear:(BOOL)animated {
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
