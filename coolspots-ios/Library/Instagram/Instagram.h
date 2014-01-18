//
//  Instagram.h
//  bestspots
//
//  Created by Daniel Alcanja on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instagram : NSObject

@property(nonatomic, strong) NSString* accessToken;
-(void)logout;
-(BOOL)isSessionValid;
-(void)invalidateSession;
@end
