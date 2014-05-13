//
//  CSImageView.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/31/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSImageView.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "EGOCache.h"


inline static NSString* keyForURL(NSURL* url, NSString* style) {
	
    return [NSString stringWithFormat:@"EGOImageLoader-%lu", (unsigned long)[[url description] hash]];
    
}
@implementation CSImageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //_imageView.image = [UIImage imageNamed:@"placeholder-image"];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_imageView];
        
        //  Added black stroke
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = YES;
        
    }
    return self;
}
#pragma mark - Properties

-(UIImage *)image{
    return _imageView.image;
}

-(void)setImage:(UIImage *)newImage{
    _imageView.image = newImage;
    
    _imageView.alpha = 0.0;
    
    //  Random delay to avoid all animations happen at once
    float millisecondsDelay = (arc4random() % 700) / 1000.0f;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, millisecondsDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.alpha = 1.0;
        }];
    });
}

-(void)setHighlighted:(BOOL)highlighted{
    
    //  This avoids the animation runs every time the cell is reused
    if (_imageView.isHighlighted != highlighted){
        _imageView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.alpha = 1.0;
        }];
    }
    
    [_imageView setHighlighted:highlighted];
}

-(void)setURL:(NSString *)imageURL{
    
    //  Image set
    if ([imageURL hasPrefix:@"http://"] ||
        [imageURL hasPrefix:@"https://"]){
        NSURL *anURL = [NSURL URLWithString:imageURL];
        
        UIImage* anImage = [[EGOCache currentCache] imageForKey:keyForURL(anURL,nil)];
        if(anImage) {
            self.image = anImage;
        }else {
            
            //  Download image from the web
            void (^imageSuccess)(UIImage *downloadedImage) = ^(UIImage *downloadedImage){
                
                self.image = downloadedImage;
                [[EGOCache currentCache] setImage:self.image forKey:keyForURL(anURL, nil) withTimeoutInterval:604800];
                
            };
            
            NSURL *anURL = [NSURL URLWithString:imageURL];
            NSURLRequest *anURLRequest = [NSURLRequest requestWithURL:anURL];
            AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:anURLRequest
                                                                                                   success:imageSuccess];
            [operation start];
            
        }
    }else{
        //  Load image from bundle
        self.image = [UIImage imageNamed:imageURL];
    }
}

-(void)prepareForReuse{
    self.image = nil;
}

@end
