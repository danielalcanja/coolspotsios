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
    int nextI;

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
    nextI = 0;
    
}

-(IBAction)importCity:(id)sender {
    
    
    [DejalBezelActivityView activityViewForView:self.view];

    [[CSAPI sharedInstance] getTredingLocationWithDelegate:self];
    
}

-(void)getTredingLocationsSucceeded:(NSDictionary *)dictionary {
    
    
    for(int i=0;i<[dictionary count];i++) {
        
        FSLocation *location = [[FSLocation alloc] init];
        location.id_foursquare = [dictionary valueForKey:@"id"][i];
        location.name = [dictionary valueForKey:@"name"][i];
        location.address = [dictionary valueForKey:@"address"][i];
        location.postal_code = [dictionary valueForKey:@"postalCode"][i];
        NSMutableDictionary *geo = [[NSMutableDictionary alloc]init];
        [geo setValue:[dictionary valueForKey:@"countryName"][i] forKey:@"countryName"];
        [geo setValue:[dictionary valueForKey:@"countryCode"][i] forKey:@"countryCode"];
        [geo setValue:[dictionary valueForKey:@"stateName"][i] forKey:@"stateName"];
        [geo setValue:[dictionary valueForKey:@"cityName"][i] forKey:@"cityName"];
        location.geo = geo;
        NSMutableDictionary *category = [[NSMutableDictionary alloc]init];
        [category setValue:@"0" forKey:@"id"];
        [category setValue:[dictionary valueForKey:@"category"][i] forKey:@"name"];
        [category setValue:[dictionary valueForKey:@"idcategory"][i] forKey:@"exid"];
        location.category = category;
        [objects addObject:location];
        
    }
    if([dictionary count] > 0) {
        
        FSLocation *location = [objects objectAtIndex:nextI];
        
        [[CSAPI sharedInstance] getInstagramIDLocationWithFoursquareID:location.id_foursquare delegate:self];
    }
    
}
-(void)getTredingLocationsError:(NSError *)error {

    NSLog(@"getTredingLocationsError %@", error);
}

-(void)getInstagramIDLocationSucceeded:(NSMutableArray *)dictionary {
    
    FSLocation *location = [objects objectAtIndex:nextI];
    
    if([dictionary count] > 0) {
     
        NSMutableDictionary *dicLocation = [[NSMutableDictionary alloc]init];
        [dicLocation setValue:[dictionary valueForKey:@"id"][0] forKey:@"id_instagram"];
        [dicLocation setValue:location.id_foursquare forKey:@"id_foursquare"];
        [dicLocation setValue:location.geo forKey:@"geo"];
        [dicLocation setValue:location.category forKey:@"category"];
        [dicLocation setValue:location.name forKey:@"name"];
        [dicLocation setValue:location.address forKey:@"address"];
        [dicLocation setValue:location.postal_code forKey:@"postal_code:"];
        
        [[CSAPI sharedInstance] addLocationWithDictionary:dicLocation delegate:self];

        
    }
    else {
        
        nextI = 0;
        [DejalBezelActivityView removeViewAnimated:YES];
        
    }

}
-(void)getAddLocationSucceeded:(NSMutableArray *)dictionary {
    
    nextI++;
    
    if([objects count] > nextI) {
        
        FSLocation *location = [objects objectAtIndex:nextI];
        [[CSAPI sharedInstance] getInstagramIDLocationWithFoursquareID:location.id_foursquare delegate:self];
        
    }else {
        
        nextI = 0;
        [DejalBezelActivityView removeViewAnimated:YES];

    }

}
-(void)getAddLocationError:(NSError *)error {
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
