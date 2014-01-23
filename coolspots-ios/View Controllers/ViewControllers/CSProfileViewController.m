//
//  CSProfileViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/21/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSProfileViewController.h"
#import "CSImageView.h"

@interface CSProfileViewController ()

@end

@implementation CSProfileViewController {
    
    UITableView *tableProfile;
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
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelTitle.text = @"Profile";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;
    
    tableProfile = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableProfile.delegate = self;
    tableProfile.dataSource = self;
    tableProfile.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableProfile];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 1;
    if(section==1) {
        numberOfRows = 8;
    }
    return numberOfRows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if(indexPath.section==0) {
            
            if(indexPath.row==0) {
                
                UIImageView *bgProfile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
                bgProfile.frame = CGRectMake(0, 0, 320, 200);
                [cell addSubview:bgProfile];
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                
                CSImageView *profilePic = [[CSImageView alloc] initWithFrame:CGRectMake(320/2-50, 50, 100, 100)];
                [profilePic setURL:[prefs objectForKey:@"profile_picture"]];
                [cell addSubview:profilePic];
                
            }
            
        }
        if(indexPath.section==1) {
            
            if(indexPath.row==0) {
                
                UILabel *labelMessages = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                labelMessages.textAlignment = NSTextAlignmentLeft;
                [labelMessages setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                labelMessages.textColor = [UIColor lightGrayColor];
                labelMessages.text = @"Mensages";
                [cell addSubview:labelMessages];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==1) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Tell a friend";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==2) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Give a feedback";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==3) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Rate us on Apple Store";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==4) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Color";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==5) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Settings";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            if(indexPath.row==6) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 190, 50)];
                label.textAlignment = NSTextAlignmentLeft;
                [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"Logout";
                [cell addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            
            
        }
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 50;
    if(indexPath.row==0 && indexPath.section==0) {
        height = 200;
    }
    return height;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *viewUserInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    
    UIImageView *bgProfile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
    bgProfile.frame = CGRectMake(0, 0, 320, 70);
    [viewUserInfo addSubview:bgProfile];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 320, 30)];
    labelName.textAlignment = NSTextAlignmentCenter;
    [labelName setFont:[UIFont fontWithName:@"Museo-500" size:16]];
    labelName.textColor = [UIColor whiteColor];
    labelName.text = [prefs objectForKey:@"full_name"];
    [viewUserInfo addSubview:labelName];
    
    UILabel *labelBio = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 320, 40)];
    labelBio.textAlignment = NSTextAlignmentCenter;
    labelBio.numberOfLines = 3;
    [labelBio setFont:[UIFont fontWithName:@"Museo-300" size:13]];
    labelBio.textColor = [UIColor whiteColor];
    labelBio.text = [prefs objectForKey:@"bio"];
    [viewUserInfo addSubview:labelBio];
    
    return viewUserInfo;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;

    if(section==1) {
        height = 70;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
