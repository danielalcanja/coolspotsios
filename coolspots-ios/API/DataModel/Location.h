//
//  Location.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 4/11/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Geo.h"

typedef enum {
    kMosaicLayoutTypeUndefined2,
    kMosaicLayoutTypeSingle2,
    kMosaicLayoutTypeDouble2
} MosaicLayoutType2;

@interface Location : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *active;
@property (strong, nonatomic) NSString *foursquqreid;
@property (strong, nonatomic) NSString *instagramid;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *cc;
@property (strong, nonatomic) NSString *coverpic;


@property (assign) BOOL firstTimeShown;
@property (assign) float relativeHeight;
@property (assign) MosaicLayoutType2 layoutType;


@property (strong, nonatomic) Geo *geo;

@end
