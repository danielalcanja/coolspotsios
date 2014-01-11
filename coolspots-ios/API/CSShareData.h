//
//  CSShareData.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/9/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CSShareData : NSObject

+ (id)sharedInstance;
@property (strong, atomic) CLPlacemark *placemark;



@end
