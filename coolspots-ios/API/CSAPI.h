//
//  CSAPI.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/7/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@interface CSAPI : NSObject

@property (strong, atomic) AFHTTPClient *httpClient;
@property (strong, atomic) NSSet *additionalAcceptableContentTypes;

@end
