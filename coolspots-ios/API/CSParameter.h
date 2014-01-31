//
//  CSParameter.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/30/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSParameter : NSObject
@property (assign, nonatomic) NSNumber *id;
@property (assign, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSObject *obj;


@end
