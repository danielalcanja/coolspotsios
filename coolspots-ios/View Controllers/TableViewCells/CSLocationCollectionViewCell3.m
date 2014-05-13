//
//  CSLocationCollectionViewCell3.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/6/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSLocationCollectionViewCell3.h"
#import "EGOImageView.h"
#import <AFNetworking.h>
#import "CSImageView.h"
#import "EGOCache.h"


inline static NSString* keyForURL(NSURL* url, NSString* style) {
	
    return [NSString stringWithFormat:@"EGOImageLoader-%lu", (unsigned long)[[url description] hash]];
    
}

@implementation CSLocationCollectionViewCell3 {
    UIImageView *egoImageView;
    CSImageView *userPic;
    UILabel *labelUser;
    UIView *subView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect frameSubView = self.bounds;
        subView = [[UIView alloc] initWithFrame:frameSubView];
        subView.backgroundColor = [UIColor clearColor];
        [self addSubview:subView];
        
        egoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 247, 247)];
        egoImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [subView addSubview:egoImageView];
        
        UIImage *image1=[UIImage imageNamed:@"tarja-principal-pic"];
        UIImageView *imageTarja= [[UIImageView alloc] initWithImage:image1];
        imageTarja.frame = CGRectMake(0, 200, 247, 47);
        [subView  addSubview:imageTarja];
        
        userPic = [[CSImageView alloc] initWithFrame:CGRectMake(10, 205, 40, 40)];
        [subView addSubview:userPic];
        
        labelUser = [[UILabel alloc] initWithFrame:CGRectMake(60, 205, 240, 40)];
        [labelUser setFont:[UIFont fontWithName:@"Museo-700" size:13]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [subView addSubview:labelUser];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0].CGColor;
        self.clipsToBounds = YES;
        
    }
    return self;

}
-(void)cropImage {
    
    UIImage *anImage = egoImageView.image;
    
    if (anImage) {
        
        egoImageView.contentMode = UIViewContentModeScaleAspectFill;
        egoImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        egoImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        egoImageView.clipsToBounds = YES;
    }
    
}
#pragma mark - Properties

-(UIImage *)image{
    return egoImageView.image;
}

-(void)setImage:(UIImage *)newImage{
    
    egoImageView.image = newImage;
    
    [self cropImage];
    
    if (self.pic.firstTimeShown){
        self.pic.firstTimeShown = NO;
        
        egoImageView.alpha = 0.0;
        
        //  Random delay to avoid all animations happen at once
        float millisecondsDelay = (arc4random() % 700) / 1000.0f;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, millisecondsDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                egoImageView.alpha = 1.0;
            }];
        });
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    
    if (self.isHighlighted != highlighted){
        egoImageView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            egoImageView.alpha = 1.0;
        }];
    }
    [super setHighlighted:highlighted];
}


-(void)initWithPic:(CSPic*)pic {
    
    self.pic = pic;
    
    //  Image set
    if ([pic.standardResolution hasPrefix:@"http://"] ||
        [pic.standardResolution hasPrefix:@"https://"]){
        NSURL *anURL = [NSURL URLWithString:pic.standardResolution];

        UIImage* anImage = [[EGOCache currentCache] imageForKey:keyForURL(anURL,nil)];
        if(anImage) {
            self.image = anImage;
        }else {
            
            //  Download image from the web
            void (^imageSuccess)(UIImage *downloadedImage) = ^(UIImage *downloadedImage){
                
                //  This check is to avoid wrong images on reused cells
                if ([pic.standardResolution isEqualToString:_pic.standardResolution]){
                    self.image = downloadedImage;
                    [[EGOCache currentCache] setImage:self.image forKey:keyForURL(anURL, nil) withTimeoutInterval:604800];
                }
            };
            
            NSURLRequest *anURLRequest = [NSURLRequest requestWithURL:anURL];
            AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:anURLRequest
                                                                                                   success:imageSuccess];
            [operation start];
        }
    }else{
        //  Load image from bundle
        self.image = [UIImage imageNamed:pic.standardResolution];
    }
    
    labelUser.text = pic.userFullname;
    [userPic setURL:pic.profilePicture];

}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self cropImage];
}
-(void)prepareForReuse{
    [super prepareForReuse];
}

@end
