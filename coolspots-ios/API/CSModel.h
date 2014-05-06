//
//  CSModel.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/1/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSModel : NSObject

+ (id)sharedInstance;

@property (strong, atomic) NSCache *assetsThumbnail;


@end
