//
//  CSComment.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSComment : NSObject

@property (assign, nonatomic) int id;
@property (assign, nonatomic) NSString *username;
@property (assign, nonatomic) NSString *text;
@property (assign, nonatomic) NSString *date;
@property (assign, nonatomic) NSString *profilePicture;
@end
