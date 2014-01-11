//
//  CSLocationDetailSmallPicCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationDetailSmallPicCell.h"

@implementation CSLocationDetailSmallPicCell {
    
    EGOImageView *egoImageView1;
    EGOImageView *egoImageView2;
    EGOImageView *egoImageView3;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        CGFloat size = 108;
        
        egoImageView1 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView1.frame = CGRectMake(-2, 0, size, size);
        
        [self.contentView addSubview:egoImageView1];
        
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = egoImageView1.frame;
        button1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:button1];
        
        egoImageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView2.frame = CGRectMake(size-3, 0, size, size);
        
        [self.contentView addSubview:egoImageView2];
        
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = egoImageView2.frame;
        button2.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:button2];
        
        egoImageView3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView3.frame = CGRectMake((size*2)-4, 0, size, size);
        
        [self.contentView addSubview:egoImageView3];
        
        button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = egoImageView3.frame;
        button3.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:button3];
        
    }
    return self;
}
-(void)reloadCellWithLocation:(CSPic*)pic1 andPic2:(CSPic*)pic2 andPic3:(CSPic*)pic3  withViewController:(UIViewController*)viewController{
    
    egoImageView1.imageURL = [NSURL URLWithString:pic1.thumbnail];
    [button1 addTarget:viewController action:@selector(didSelectPic:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = [pic1.id integerValue];
    egoImageView2.imageURL = [NSURL URLWithString:pic2.thumbnail];
    [button2 addTarget:viewController action:@selector(didSelectPic:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = [pic2.id integerValue];

    egoImageView3.imageURL = [NSURL URLWithString:pic3.thumbnail];
    [button3 addTarget:viewController action:@selector(didSelectPic:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = [pic3.id integerValue];

    
    
}

-(IBAction)didSelectPic:(id)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
