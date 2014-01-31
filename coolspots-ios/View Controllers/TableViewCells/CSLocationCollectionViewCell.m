//
//  CSLocationCollectionViewCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationCollectionViewCell.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

#define kLabelHeight 20
#define kLabelMargin 7


@implementation CSLocationCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect frameView = self.bounds;
        view  = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        
        _imageView = [[UIImageView alloc] initWithFrame:frameView];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view addSubview:_imageView];
        
        UIImage *image1=[UIImage imageNamed:@"tarja-principal-pic"];
        imageTarja= [[UIImageView alloc] initWithImage:image1];
        [view  addSubview:imageTarja];
        
        _labelTitlePlace = [[UILabel alloc] init];
        _labelTitlePlace.frame = CGRectMake(6, 320, 250, 44);
        [_labelTitlePlace setFont:[UIFont fontWithName:@"Museo-700" size:13]];
        _labelTitlePlace.backgroundColor = [UIColor clearColor];
        _labelTitlePlace.textColor = [UIColor whiteColor];
        _labelTitlePlace.shadowColor = [UIColor blackColor];
        _labelTitlePlace.shadowOffset = CGSizeMake(0, 1);
        _labelTitlePlace.numberOfLines = 1;
        [view addSubview:_labelTitlePlace];
        
       
        
        //  Added black stroke
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = YES;
        
    }
    return self;
}
-(void)reloadCellWithLocation:(CSLocation*)location {
    
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
    
    if (_location.firstTimeShown){
        _location.firstTimeShown = NO;
        
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

-(void)setMosaicData:(CSLocation *)newMosaicData{
    
    NSString *standard_resolution = [[_location.lastPhotos objectAtIndex:0] objectForKey:@"standard_resolution"];
    
    
    //  Image set
    if ([standard_resolution hasPrefix:@"http://"] ||
        [standard_resolution hasPrefix:@"https://"]){
        //  Download image from the web
        void (^imageSuccess)(UIImage *downloadedImage) = ^(UIImage *downloadedImage){
            
            //  This check is to avoid wrong images on reused cells
            if ([newMosaicData.name isEqualToString:_location.name]){
                self.image = downloadedImage;
            }
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
    
    
    //  Title se
    _labelTitlePlace.text = _location.name;
}

#pragma mark - Public




-(void)layoutSubviews{
    [super layoutSubviews];
    
    _labelTitlePlace.frame = CGRectMake(kLabelMargin,
                                   self.bounds.size.height - kLabelHeight - kLabelMargin,
                                   self.bounds.size.width,
                                   kLabelHeight+kLabelMargin);
    
    imageTarja.frame=CGRectMake(0,self.bounds.size.height - kLabelHeight - kLabelMargin,
                                self.bounds.size.width,
                                kLabelHeight+kLabelMargin-2);

    
    [self cropImage];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.image = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
