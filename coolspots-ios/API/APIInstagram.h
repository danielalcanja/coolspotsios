//
//  APIInstagram.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 4/10/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFClient.h"

@protocol CSGetMediaCaller<NSObject>
@required
- (void) getMediaSucceeded:(NSDictionary*)response;
- (void) getMediaError:(NSError*)error;
@end

@interface APIInstagram : NSObject

@property (strong, atomic) GFClient *gf;
@property (strong, atomic) NSString *session;
+ (id)sharedInstance;
- (id)initWithGFClient:(GFClient*)gfClient;

- (void)getMediaWithID:(NSString*)idmedia MAX_ID:(NSString*)next_max_id delegate:(id<CSGetMediaCaller>)delegate;
@end
