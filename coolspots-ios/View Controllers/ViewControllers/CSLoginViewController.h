//
//  CSLoginViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/15/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAPI.h"
#import "CoolSpotsAPI.h"



@interface CSLoginViewController : UIViewController<UIWebViewDelegate,CSInstagramUserInfoDelegate,AddUserCaller,LoggingUserCaller>

@end
