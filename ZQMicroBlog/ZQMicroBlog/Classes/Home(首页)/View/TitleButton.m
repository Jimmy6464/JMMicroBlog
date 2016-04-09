//
//  TitleButton.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateHighlighted];
        self.adjustsImageWhenDisabled = NO;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self sizeToFit];
    }
    return self;
}
- (void)layoutSubviews
{

    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    CGFloat imageX = self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x + 5;
    self.imageView.frame = CGRectMake(imageX, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
}


@end
