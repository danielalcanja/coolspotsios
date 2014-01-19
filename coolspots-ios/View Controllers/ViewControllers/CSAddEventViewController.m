//
//  CSAddEventViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSAddEventViewController.h"
#import "CSDatePickerViewController.h"
#import "CSSearchLocationViewController.h"

@interface CSAddEventViewController ()

@end

@implementation CSAddEventViewController {
    
    UITableView *eventsTable;
    NSString *placeHolder;
    UISwitch *swtPublic;
    NSString *public;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelTitle.text = @"Create Event";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;

    eventsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
    eventsTable.backgroundColor = [UIColor clearColor];
    eventsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:eventsTable];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(insertEvent:)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];

}
-(IBAction)cancel:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}
-(IBAction)insertEvent:(id)sender {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 7;
    return numberOfRows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        NSInteger row = indexPath.row;
        
        if(row==0) {
            
            UITextField *txtName = [[UITextField alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            txtName.placeholder = @"Name";
            [txtName setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:txtName];
            
        }
        if(row==1) {
            
            placeHolder = @"Description";
            UITextView *txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, 140, 100)];
            [txtDescription setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            txtDescription.text = placeHolder;
            txtDescription.delegate = self;
            txtDescription.textColor = [UIColor lightGrayColor];
            [cell addSubview:txtDescription];
            
        }
        if(row==2) {
            
            UITextField *txtName = [[UITextField alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            txtName.placeholder = @"Tag";
            [txtName setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:txtName];
            
        }
        if(row==3) {
            
            UILabel *labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            labelLocation.text = @"Location";
            [labelLocation setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:labelLocation];
            
            self.labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(95, 5, 190, 50)];
            self.labelLocation.textAlignment = NSTextAlignmentRight;
            [self.labelLocation setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            self.labelLocation.textColor = [UIColor lightGrayColor];
            [cell addSubview:self.labelLocation];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==4) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            label.text = @"Date Start";
            [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:label];

            self.labelStart = [[UILabel alloc] initWithFrame:CGRectMake(95, 5, 190, 50)];
            self.labelStart.textAlignment = NSTextAlignmentRight;
            [self.labelStart setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            self.labelStart.textColor = [UIColor lightGrayColor];
            [cell addSubview:self.labelStart];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==5) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            label.text = @"Date End";
            [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:label];
            
            self.labelEnd = [[UILabel alloc] initWithFrame:CGRectMake(95, 5, 190, 50)];
            self.labelEnd.textAlignment = NSTextAlignmentRight;
            [self.labelEnd setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            self.labelEnd.textColor = [UIColor lightGrayColor];
            [cell addSubview:self.labelEnd];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==6) {
            
            UILabel *labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 140, 50)];
            labelLocation.text = @"Public";
            [labelLocation setFont:[UIFont fontWithName:@"Museo-500" size:16]];
            [cell addSubview:labelLocation];
            
            swtPublic = [[UISwitch alloc] init];
            swtPublic.frame = CGRectMake(0, 0, 39, 20);
            swtPublic.tag = 3;
            cell.accessoryView = swtPublic;
            swtPublic.on = NO;
            [swtPublic addTarget:self action:@selector(switchPublic:) forControlEvents:UIControlEventValueChanged];

        }
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;

    CGFloat height = 60;
    if(row==1) {
        height = 90;
    }
    
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if(row==3) {
        
        CSSearchLocationViewController *goView = [[CSSearchLocationViewController alloc] init];
        [self.navigationController pushViewController:goView animated:YES];
    }
    if(row==4) {
        
        CSDatePickerViewController *datePickerView = [[CSDatePickerViewController alloc] initWithStyle:UITableViewStylePlain];
        datePickerView.typeDate = 0;
        [self.navigationController pushViewController:datePickerView animated:YES];
        
    }
    if(row==5) {
        
        CSDatePickerViewController *datePickerView = [[CSDatePickerViewController alloc] initWithStyle:UITableViewStylePlain];
        datePickerView.typeDate = 1;
        [self.navigationController pushViewController:datePickerView animated:YES];
        
        
    }
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = placeHolder;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (void)switchPublic:(UISwitch *)sender {
	if(sender.on==FALSE){
		
        public = @"N";
        
	}else
    {
        public = @"Y";

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
