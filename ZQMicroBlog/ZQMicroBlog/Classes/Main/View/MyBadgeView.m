//
//  MyBadgeView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MyBadgeView.h"

@implementation MyBadgeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        CGSize size = [self backgroundImageForState:UIControlStateNormal].size;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    if (_badgeValue == nil || [_badgeValue isEqualToString:@""] || [_badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    [self setTitle:_badgeValue forState:UIControlStateNormal];
    //获取lable的长度
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    if (size.width > self.frame.size.width) {//如果文字的宽度比按钮的宽度宽
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
    }else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
