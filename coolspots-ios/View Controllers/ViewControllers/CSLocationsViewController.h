//
//  CSLocationsViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicLayoutDelegate.h"
#import <YIFullScreenScroll.h>


@interface CSLocationsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,MosaicLayoutDelegate,UIScrollViewDelegate> {
    UICollectionView *locationCollectionView;

}

@end
