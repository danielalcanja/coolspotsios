//
//  CSLocationDetailViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLocation.h"
#import "MosaicLayoutDelegate.h"
#import "CoolSpotsAPI.h"
#import "APIInstagram.h"

@interface CSLocationDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MosaicLayoutDelegate,CSPhotosDelegateCaller,CSGetMediaCaller> {
    UICollectionView *picsCollectionView;

}

@property  (nonatomic,strong) Location *location;
@property (strong) NSString *maxID;


@end
