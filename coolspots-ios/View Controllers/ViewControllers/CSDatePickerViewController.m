//
//  CSDatePickerViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSDatePickerViewController.h"
#import "CSAddEventViewController.h"

@interface CSDatePickerViewController ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation CSDatePickerViewController {
    
    UIDatePicker *datePicker;
    NSDate *selectedDate;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select Time";
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
   
}
-(IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)done:(id)sender {
    
    CSAddEventViewController *goView  = [self.navigationController.viewControllers objectAtIndex:0];
    if(self.typeDate==0) {
        goView.dateStart = selectedDate;
        goView.labelStart.text  = [self.dateFormatter stringFromDate:selectedDate];
    }else {
        
        goView.dateEnd = selectedDate;
        goView.labelEnd.text  = [self.dateFormatter stringFromDate:selectedDate];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        NSInteger row = indexPath.row;
        if(row==0) {
            cell.textLabel.text = @"Date & Time";
            cell.detailTextLabel.text = @"Today";
        }
        if(row==1) {
            
            CGRect pickerFrame = CGRectMake(0,0,320,216);
            datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
            [datePicker addTarget:self action:@selector(pickerDateChanged:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:datePicker];
            
        }
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    CGFloat height = 60;
    if(row==1) {
        height = 216;
    }
    
    return height;
}

#pragma mark - Action methods

- (IBAction)pickerDateChanged:(UIDatePicker *)sender {

    NSIndexPath *parentCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:parentCellIndexPath];
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sender.date];
    selectedDate = sender.date;

}

@end
