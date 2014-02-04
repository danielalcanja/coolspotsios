//
//  CSPicCollectionViewCell2.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/1/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSPicCollectionViewCell2.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

#define kLabelHeight 20
#define kLabelMargin 7

@implementation CSPicCollectionViewCell2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_imageView];
        
        //  Added black stroke
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = YES;
    
    }
    return self;
}

-(void)cropImage {
    
    UIImage *anImage = _imageView.image;
    
    if (anImage) {
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _imageView.clipsToBounds = YES;
        
    }
    
}

#pragma mark - Properties

-(UIImage *)image{
    return _imageView.image;
}

-(void)setImage:(UIImage *)newImage{
    _imageView.image = newImage;
    
    [self cropImage];
    
    if (_picture.firstTimeShown){
        _picture.firstTimeShown = NO;
        
        _imageView.alpha = 0.0;
        
        //  Random delay to avoid all animations happen at once
        float millisecondsDelay = (arc4random() % 700) / 1000.0f;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, millisecondsDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                _imageView.alpha = 1.0;
            }];
        });
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    
    //  This avoids the animation runs every time the cell is reused
    if (self.isHighlighted != highlighted){
        _imageView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.alpha = 1.0;
        }];
    }
    
    [super setHighlighted:highlighted];
}
-(void)setMosaicDataWithPic:(CSPic *)pic{
    
    NSString *standard_resolution = pic.standardResolution;
    
    
    //  Image set
    if ([standard_resolution hasPrefix:@"http://"] ||
        [standard_resolution hasPrefix:@"https://"]){
        //  Download image from the web
        void (^imageSuccess)(UIImage *downloadedImage) = ^(UIImage *downloadedImage){
            
            /*
             if ([newMosaicData.name isEqualToString:_location.name]){
             self.image = downloadedImage;
             }*/
            self.image = downloadedImage;

        };
        
        NSURL *anURL = [NSURL URLWithString:standard_resolution];
        NSURLRequest *anURLRequest = [NSURLRequest requestWithURL:anURL];
        AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:anURLRequest
                                                                                               success:imageSuccess];
        [operation start];
    }else{
        //  Load image from bundle
        self.image = [UIImage imageNamed:standard_resolution];
    }
}



#pragma mark - Public

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self cropImage];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.image = nil;
}

@end
