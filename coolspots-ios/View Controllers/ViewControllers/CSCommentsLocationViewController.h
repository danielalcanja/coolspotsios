//
//  CSCommentsLocationViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLocation.h"
#import "CSCommentCell.h"
#import "CSAPI.h"

@interface CSCommentsLocationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CSCommentLocationDelegate,CSAddCommentLocationDelegate>

@property  (nonatomic,strong) CSLocation *location;
@property (assign, nonatomic) NSMutableArray *commentsObjects;


@end
