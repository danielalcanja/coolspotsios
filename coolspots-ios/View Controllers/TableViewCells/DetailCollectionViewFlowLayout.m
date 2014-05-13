//
//  DetailCollectionViewFlowLayout.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/12/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "DetailCollectionViewFlowLayout.h"

@implementation DetailCollectionViewFlowLayout


-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(247, 247);
        self.minimumInteritemSpacing = 0.0;
        self.minimumLineSpacing = 2.0f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(3,4,3,4);
    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    return array;
}


@end
