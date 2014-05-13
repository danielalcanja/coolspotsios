//
//  CSInfoLocationCollectionViewCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/6/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSInfoLocationCollectionViewCell.h"
#import "CSFavButton.h"
#import "CSCommentButton.h"
#import <MapKit/MapKit.h>


@implementation CSInfoLocationCollectionViewCell {
    
    UIView *subView;
    UILabel *_labelTitlePlace;
    UILabel *_labelAddressPlace;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect frameSubView = CGRectMake(0, 0, 270, 700);
        subView = [[UIView alloc] initWithFrame:frameSubView];
        subView.backgroundColor = [UIColor whiteColor];
        [self addSubview:subView];
        
        _labelTitlePlace = [[UILabel alloc] init];
        _labelTitlePlace.frame = CGRectMake(20, 20, 250, 84);
        [_labelTitlePlace setFont:[UIFont fontWithName:@"Museo-300" size:25]];
        _labelTitlePlace.backgroundColor = [UIColor clearColor];
        _labelTitlePlace.textColor = [UIColor lightGrayColor];
        _labelTitlePlace.numberOfLines = 3;
        [subView addSubview:_labelTitlePlace];
        
        UIView *viewBar = [[UIView alloc] initWithFrame:CGRectMake(20, 110, 230, 1)];
        [viewBar setBackgroundColor:[UIColor lightGrayColor]];
        [subView addSubview:viewBar];
        
        
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, viewBar.frame.origin.y + viewBar.frame.size.height + 10, 230, 100)];
        [subView addSubview:mapView];
        
        _labelAddressPlace = [[UILabel alloc] init];
        _labelAddressPlace.frame = CGRectMake(20, mapView.frame.origin.y + mapView.frame.size.height + 5, 150, 84);
        [_labelAddressPlace setFont:[UIFont fontWithName:@"Museo-300" size:15]];
        _labelAddressPlace.backgroundColor = [UIColor clearColor];
        _labelAddressPlace.textColor = [UIColor lightGrayColor];
        _labelAddressPlace.numberOfLines = 3;
        [subView addSubview:_labelAddressPlace];
        
        
        CGFloat spaceBtwButtons = 30;
        CGFloat spaceHight = 15;
        CGFloat headerSize = 35;

        CSFavButton *buttonFav = [[CSFavButton alloc] initWithFrame:CGRectMake(15, headerSize-spaceHight, 35,35) isFavorite:NO];
        
        CSFavButton *buttonShare = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonFav.frame.origin.x + buttonFav.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
        [buttonShare.button setBackgroundImage:[UIImage imageNamed:@"button-share"] forState:UIControlStateNormal];
        
        CSFavButton *buttonEvent = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonShare.frame.origin.x + buttonShare.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
        [buttonEvent.button setBackgroundImage:[UIImage imageNamed:@"button-events"] forState:UIControlStateNormal];
        
        
        CSCommentButton *buttonComments = [[CSCommentButton alloc] initWithFrame:CGRectMake(buttonEvent.frame.origin.x + buttonEvent.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35)];
        
        CSFavButton *buttonMoreInfo = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonComments.frame.origin.x + buttonComments.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
        [buttonMoreInfo.button setBackgroundImage:[UIImage imageNamed:@"button-more"] forState:UIControlStateNormal];        
        
    }
    return self;
    
}
-(void)initWithLocation:(Location *)location {
    
    _labelTitlePlace.text = location.name;
    _labelAddressPlace.text = @"41 Linden st, Everett - 02218";
    
}

@end
