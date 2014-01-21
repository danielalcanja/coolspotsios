//
//  CSSlideViewImage.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/21/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSSlideViewImage.h"

@implementation CSSlideViewImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[CSImageView alloc] initWithFrame:CGRectMake(0, 0, 320,320)];
        [self addSubview:self.imageView];
        
        self.bgCaption = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tarja-principal-pic"]];
        self.bgCaption.frame=CGRectMake(0,270,320,50);
        [self  addSubview:self.bgCaption];
        
        self.labelCaption = [[UILabel alloc] initWithFrame:CGRectMake(6,270,300,50)];
        [self.labelCaption setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        self.labelCaption.numberOfLines = 3;
        self.labelCaption.backgroundColor  = [UIColor clearColor];
        self.labelCaption.textColor  = [UIColor whiteColor];
        [self addSubview:self.labelCaption];
    
    }
    return self;
}

-(void)reloadDataWithImageUrl:(NSString*)imageUrl caption:(NSString*)caption {
 
     [self.imageView setURL:imageUrl];
    self.labelCaption.text = caption;

    
}

@end
