//
//  CSEventsViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/27/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGORefreshTableHeaderView.h>
#import "CSAPI.h"

@interface CSEventsViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,CSEventsDelegate>

@end
