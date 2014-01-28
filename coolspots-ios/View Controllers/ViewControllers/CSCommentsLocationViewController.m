//
//  CSCommentsLocationViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSCommentsLocationViewController.h"
#import "BackButton.h"
#import <DejalActivityView.h>

@interface CSCommentsLocationViewController ()

@end

@implementation CSCommentsLocationViewController {
    
    UITableView *commentsTable;
    NSMutableArray *objects;
    int page;

    
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
    
    page = 1;
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 70)];
    labelTitle.text = self.location.name;
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    
    self.navigationItem.titleView = labelTitle;
    
    UIButton* backButton = [[BackButton alloc] backButtonWith:[UIImage imageNamed:@"button-back"] withTtle:@"" leftCapWidth:20];
    [backButton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    commentsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    commentsTable.delegate = self;
    commentsTable.dataSource = self;
    commentsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:commentsTable];
    
    objects = [[NSMutableArray alloc] init];
    
    [DejalBezelActivityView activityViewForView:self.view];
    [self loadData];
}
-(IBAction)closeView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)loadData{
    [[CSAPI sharedInstance] getCommentWithIDLocation:[NSNumber numberWithInt:self.location.id] page:[NSNumber numberWithInt:page] delegate:self];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *username = [prefs stringForKey:@"username"];
    
    
    //[[CSAPI sharedInstance] addCommentWithIDLocation:[NSNumber numberWithInt:self.location.id] username:username text:@"Test comments" delegate:self];
    
}
-(void)getCommentLocationSucceeded:(NSMutableArray *)dictionary {
    
}
-(void)getCommentLocationError:(NSError *)error {
    
    NSLog(@"getCommentLocationError %@", error);
    
}
-(void)addCommentLocationSucceeded:(NSMutableArray *)dictionary {
    
}
-(void) addCommentLocationError:(NSError *)error {
    
    NSLog(@"addCommentLocationError %@", error);

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [objects count];
    return numberOfRows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSComment *comment = [objects objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"commentCell"] ;
    CSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CSCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell reloadDataWith:comment];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
