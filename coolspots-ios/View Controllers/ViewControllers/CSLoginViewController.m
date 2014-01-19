//
//  CSLoginViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/15/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSLoginViewController.h"
#import "AppDelegate.h"
#import "BackButton.h"  
#import "CSUser.h"
#import "CSSharedData.h"

static NSString *const authUrlString = @"https://api.instagram.com/oauth/authorize";
static NSString *const tokenUrlString = @"https://api.instagram.com/oauth/access_token/";
// ADD YOUR CLIENT ID AND SECRET HERE
static NSString *const clientID = @"ff47f1dcba9d44868038a2b3f610a6dc";
static NSString *const clientSecret = @"13deed060dbc459cb3991dfae66ff2ca";

// YOU NEED A BAD URL HERE - THIS NEEDS TO MATCH YOUR URL SET UP FOR YOUR
// INSTAGRAM APP
static NSString *const redirectUri = @"http://www.google.com/NeverGonnaFindMe/";

// CHANGE TO THE SCOPE YOU NEED ACCESS TO
static NSString *const scope = @"basic+comments+likes";


@interface CSLoginViewController ()

@end

@implementation CSLoginViewController {
    
    UIWebView *webView;
    UIActivityIndicatorView * _activityIndicator;

}

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
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizesSubviews = YES;
    webView.delegate = self;
    
    // Do any additional setup after loading the view.
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@/?client_id=%@&redirect_uri=%@&scope=%@&response_type=token&display=touch",
                                   authUrlString,
                                   clientID,
                                   redirectUri,
                                   scope
                                   ];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    NSURLRequest *myRequest = [[NSURLRequest alloc] initWithURL:authUrl];
    [webView loadRequest:myRequest];
    
    [self.view addSubview:webView];

    
    self.title = @"Login with Instagram";
    UIButton* backButton = [[BackButton alloc] backButtonWith:[UIImage imageNamed:@"button-back"] withTtle:@"" leftCapWidth:20];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// GRAB THE URL TRAFFIC TO CATCH THE ACCESS TOKEN OUT OF THE RETURN URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    NSURL *Url = [request URL];
        
    NSArray *UrlParts = [Url pathComponents];
    if ([[UrlParts objectAtIndex:(1)] isEqualToString:@"NeverGonnaFindMe"]) {
        // CONVERT TO STRING AN CLEAN
        NSString *urlResources = [Url resourceSpecifier];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"?" withString:@""];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // SEPORATE OUT THE URL ON THE /
        NSArray *urlResourcesArray = [urlResources componentsSeparatedByString:@"/"];
        // THE LAST OBJECT IN THE ARRAY
        NSString *urlParamaters = [urlResourcesArray objectAtIndex:([urlResourcesArray count]-1)];
        // SEPORATE OUT THE URL ON THE &
        NSArray *urlParamatersArray = [urlParamaters componentsSeparatedByString:@"&"];
        
        if([urlParamatersArray count] == 1) {
                    
            NSString *keyValue = [urlParamatersArray objectAtIndex:(0)];
            NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
            
            if([[keyValueArray objectAtIndex:(0)] isEqualToString:@"access_token"]) {
                
                NSString *access_token = [keyValueArray objectAtIndex:(1)] ;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:access_token forKey:@"access_token"];
                
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.instagram.accessToken = access_token;
                NSLog(@"access_token %@", appDelegate.instagram.accessToken);
                [prefs synchronize];
                
                [[CSAPI sharedInstance] getInstagramUserInfoWithToken:appDelegate.instagram.accessToken delegate:self];
                
            }
        } else {
            // THERE WAS AN ERROR
        }
        
        return YES;
    }
    return YES;
}
-(void)getInstagramUserInfoSucceeded:(NSMutableArray *)dictionary {
    
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    CSUser *user = [[CSUser alloc] init];
    user.username = [dictionary valueForKey:@"username"];
    user.id = [dictionary valueForKey:@"id"];
    user.full_name = [dictionary valueForKey:@"full_name"];
    user.profile_picture = [dictionary valueForKey:@"profile_picture"];

    [[CSSharedData sharedInstance] setCurrentUser:user];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:user.username forKey:@"username"];
    [prefs synchronize];

    [[CSAPI sharedInstance] addUserWithUser:user token:appDelegate.instagram.accessToken delegate:self];
    
}
-(void)getInstagramUserInfoError:(NSError *)error {
    
    NSLog(@"Error %@", error);
    
}
-(void)addUserSucceeded:(NSMutableArray *)dictionary {
    
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    CSTabBarController *tabBarController = [[CSTabBarController alloc] init];
    appDelegate.window.rootViewController = tabBarController;
    
}
-(void)addUserError:(NSError *)error {
    
    NSLog(@"Error %@", error);
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	
	_activityIndicator = [[UIActivityIndicatorView alloc] init];
	CGPoint newCenter = (CGPoint) [self.view center];
	_activityIndicator.center = newCenter;
    [self.view addSubview:_activityIndicator];
	[_activityIndicator startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicator stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
