//
//  CSAddEventViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAPI.h"


@interface CSAddEventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>


@property  (nonatomic,strong) NSDate *dateStart;
@property  (nonatomic,strong) NSDate *dateEnd;
@property  (nonatomic,strong) UILabel *labelStart;
@property  (nonatomic,strong) UILabel *labelEnd;
@property  (nonatomic,strong) UILabel *labelLocation;
@property  (nonatomic) int selectedIdLocation;





@end
