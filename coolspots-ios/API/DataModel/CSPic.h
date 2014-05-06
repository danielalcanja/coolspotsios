//
//  CSPic.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kPicMosaicLayoutTypeUndefined,
    kPicMosaicLayoutTypeSingle,
    kPicMosaicLayoutTypeDouble
} MosaicPicLayoutType;

@interface CSPic : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *lowResolution;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *standardResolution;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *profilePicture;
@property (assign) BOOL isLiked;
@property (assign) BOOL firstTimeShown;
@property (assign) float relativeHeight;
@property (assign) MosaicPicLayoutType layoutType;
@property (strong, atomic) NSArray *data;

@property (assign) NSInteger  numberOfLike;






@end
