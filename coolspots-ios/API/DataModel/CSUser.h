//
//  CSUser.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/18/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUser : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *full_name;
@property (strong, nonatomic) NSString *profile_picture;


@end
