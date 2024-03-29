//
//  CustomDelegate.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "CustomDataSource.h"
#import "MosaicData.h"
#import "MosaicCell.h"
#import <RestKit.h>
#import "CSLocation.h"

@interface CustomDataSource()
-(void)loadFromDisk;
@end

@implementation CustomDataSource

#pragma mark - Private
-(void)loadFromDisk{
    _elements = [[NSMutableArray alloc] init];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CSLocation class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id":   @"id",
                                                  @"name":     @"name",
                                                  @"slug":        @"slug",
                                                  @"lastPhotos": @"pics"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    //NSString *urlstring = [NSString stringWithFormat:@"http://coolspot/web/json/location?page=%d", page];
    NSString *urlstring = [NSString stringWithFormat:@"http://api.coolspots.com.br/json/location?page=%@", @"1"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        /*
         CSLocation *location = [result firstObject];
         NSMutableArray *pics = location.pics;
         CSPic *pic = [[CSPic alloc] init];
         pic.standard_resolution = [pics objectAtIndex:0];
         NSLog(@"The public timeline Tweets: %@ - %@", location.name, pic.standard_resolution);
         */
        NSMutableArray *tempObjects = [[result array] mutableCopy];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [tempObjects objectAtIndex:i];
            NSString *standard_resolution = [[location.lastPhotos objectAtIndex:0] objectForKey:@"standard_resolution"];
            MosaicData *aMosaicModule = [[MosaicData alloc] init];
            aMosaicModule.imageFilename = standard_resolution;
            aMosaicModule.title = location.name;
            
            [_elements addObject:aMosaicModule];
            
        }
        
    } failure:nil];
    [operation start];

}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        [self loadFromDisk];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_elements count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    MosaicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    MosaicData *data = [_elements objectAtIndex:indexPath.row];
    cell.mosaicData = data;
    
    float randomWhite = (arc4random() % 40 + 10) / 255.0;
    cell.backgroundColor = [UIColor colorWithWhite:randomWhite alpha:1];
    return cell;
}

@end
