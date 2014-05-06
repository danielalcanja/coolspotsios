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
#import <CoreImage/CoreImage.h>

#define kLabelHeight 45
#define kLabelMargin 12
#define kLabelMarginX 4


@implementation CSLocationCollectionViewCell {
    
    NSMutableArray *objects;
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect frameView = self.bounds;
        view  = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:view];
        
        self.imageCover = [[EGOImageView alloc] initWithFrame:frameView];
        self.imageCover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view addSubview:self.imageCover];
        
        
        _labelTitlePlace = [[UILabel alloc] init];
        _labelTitlePlace.frame = CGRectMake(2, 320, 250, 44);
        [_labelTitlePlace setFont:[UIFont fontWithName:@"Museo-500" size:18]];
        _labelTitlePlace.backgroundColor = [UIColor clearColor];
        _labelTitlePlace.textColor = [UIColor whiteColor];
        _labelTitlePlace.shadowColor = [UIColor blackColor];
        _labelTitlePlace.shadowOffset = CGSizeMake(0, 1);
        _labelTitlePlace.numberOfLines = 3;
        [view addSubview:_labelTitlePlace];
        
        objects = [[NSMutableArray alloc] init];
        
        
        //  Added black stroke
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = YES;
        
    }
    return self;
}


-(void)cropImage {
    
    UIImage *anImage = self.imageCover.image;
    
    if (anImage) {
        
        self.imageCover.contentMode = UIViewContentModeScaleAspectFill;
        self.imageCover.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.imageCover.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.imageCover.clipsToBounds = YES;
    }
    
}

#pragma mark - Properties

-(UIImage *)image{
    return self.imageCover.image;
}

-(void)prepareImage{
   
    [self cropImage];
    
    if (_location.firstTimeShown){
        _location.firstTimeShown = NO;
        
        self.imageCover.alpha = 0.0;
        
        //  Random delay to avoid all animations happen at once
        float millisecondsDelay = (arc4random() % 700) / 1000.0f;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, millisecondsDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.imageCover.alpha = 1.0;
            }];
        });
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    
    //  This avoids the animation runs every time the cell is reused
    if (self.isHighlighted != highlighted){
        self.imageCover.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.imageCover.alpha = 1.0;
        }];
    }
    
    [super setHighlighted:highlighted];
}

-(void)reloadCellWithLocation:(Location*)location {
    
    self.location = location;
    _labelTitlePlace.text = _location.name;
    indexImage = 0;
    
    CSModel *model = [CSModel sharedInstance];
    Location *cacheLocation = [[model assetsThumbnail] objectForKey:location.id];
    if(!cacheLocation) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [[appDelegate apiInstagram] getMediaWithID:location.instagramid MAX_ID:nil delegate:self];
    }
    
}
-(void)getMediaSucceeded:(NSDictionary *)response {
    
    NSArray *data = [response objectForKey:@"data"];
    
    for(NSDictionary *media in data) {
        
        NSDictionary *images = [media valueForKey:@"images"];
        //NSDictionary *caption = [media valueForKey:@"caption"];
        NSDictionary *image = [images valueForKey:@"standard_resolution"];
        NSString *standard_resolution = [image valueForKey:@"url"];
        //NSString *text = [caption valueForKey:@"text"];
        
        CSPic *pic = [[CSPic alloc] init];
        pic.standardResolution = standard_resolution;
        self.standard_resolution = standard_resolution;
        
        NSDictionary *likes = [media valueForKey:@"likes"];
        pic.numberOfLike =  [[likes valueForKey:@"count"] integerValue];;
        [objects addObject:pic];
        
    }
    CSModel *model = [CSModel sharedInstance];
    [[model assetsThumbnail] setObject:self.location forKey:self.location.id];

    [self setMosaicData:self.location];
}
-(void)getMediaError:(NSError *)error {
    NSLog(@"getMediaError %@", error);
    
}
-(BOOL)hasFace:(UIImage*)imageFace {
    
    BOOL ret = NO;
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    CIImage* image = [CIImage imageWithCGImage:imageFace.CGImage];
    NSArray* features = [detector featuresInImage:image];
    if([features count]>0) {
        ret = YES;
    }
    return ret;
}
-(void)setMosaicData:(Location *)newMosaicData{
    
    CSPic *pic =  [objects objectAtIndex:indexImage];
    self.imageCover.imageURL = [NSURL URLWithString:pic.standardResolution];
    self.imageCover.alpha = 0.0;

    while (![self hasFace:self.imageCover.image]) {
        
        indexImage++;
        if([objects count] > indexImage) {
            CSPic *pic =  [objects objectAtIndex:indexImage];
            self.imageCover.imageURL = [NSURL URLWithString:pic.standardResolution];
            self.imageCover.alpha = 0.0;
            
        }else {
            break;
        }
        
    }
    
    [self prepareImage];
}

#pragma mark - Public




-(void)layoutSubviews{
    [super layoutSubviews];
    
    _labelTitlePlace.frame = CGRectMake(kLabelMarginX,
                                        self.bounds.size.height - kLabelHeight - kLabelMargin,
                                        self.bounds.size.width,
                                        kLabelHeight+kLabelMargin);
    
    
    [self cropImage];
}

-(void)prepareForReuse{
    [super prepareForReuse];
}


@end
