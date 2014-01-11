//
//  CSPrincipalViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicLayoutDelegate.h"

#define kColumnsiPadLandscape 5
#define kColumnsiPadPortrait 4
#define kColumnsiPhoneLandscape 3
#define kColumnsiPhonePortrait 2

@interface CSPrincipalViewController : UIViewController<MosaicLayoutDelegate>{
    __weak IBOutlet UICollectionView *_collectionView;
}

@end
