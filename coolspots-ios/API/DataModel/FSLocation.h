//
//  FSLocation.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/11/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSLocation : NSObject

@property (strong, nonatomic) NSString *id_instagram;
@property (strong, nonatomic) NSString *id_foursquare;
@property (strong, nonatomic) NSMutableDictionary *geo;
@property (strong, nonatomic) NSMutableDictionary *category;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *postal_code;
@property (strong, nonatomic) NSString *phone;


@end
