//
//  NewCityViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/8/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "NewCityViewController.h"
#import <RestKit.h>
#import "FSLocation.h"

@interface NewCityViewController ()

@end

@implementation NewCityViewController {
    
    NSMutableArray *objects;

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(importCity:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Import" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    objects = [[NSMutableArray alloc] init];

    
    
}

-(IBAction)importCity:(id)sender {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FSLocation class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id":   @"id",
                                                  @"name":     @"name"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    //NSString *urlstring = [NSString stringWithFormat:@"http://coolspot/web/json/location?page=%d", page];
    NSString *urlstring = [NSString stringWithFormat:@"http://igrejas.mobi/thecoolspots/RTU/"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        /*
         CSLocation *location = [result firstObject];
         NSMutableArray *pics = location.pics;
         CSPic *pic = [[CSPic alloc] init];
         pic.standard_resolution = [pics objectAtIndex:0];
         NSLog(@"The public timeline Tweets: %@ - %@", location.name, pic.standard_resolution);
         */
        NSMutableArray *tempObjects = [[result array] mutableCopy];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            FSLocation *location = [tempObjects objectAtIndex:i];
            [objects addObject:location];
            
        }
        
    } failure:nil];
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
