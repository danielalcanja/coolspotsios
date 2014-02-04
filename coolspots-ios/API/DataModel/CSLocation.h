//
//  CSLocation.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>


typedef enum {
    kMosaicLayoutTypeUndefined1,
    kMosaicLayoutTypeSingle1,
    kMosaicLayoutTypeDouble1
} MosaicLayoutType1;

@interface CSLocation : NSObject

@property (assign, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *slug;
@property (assign) BOOL favorite;
@property (assign) BOOL firstTimeShown;
@property (assign) float relativeHeight;
@property (assign) MosaicLayoutType1 layoutType;
@property (strong, atomic) NSArray *data;
@property (strong, atomic) NSArray *lastPhotos;






@end
