//
//  UserNavigationTitleLabel.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "UserNavigationTitleLabel.h"

@implementation UserNavigationTitleLabel
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*(2.0/3))];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor  = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.frame.size.height*0.8 , self.frame.size.width, self.frame.size.height*(1.0/3))];
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        _userNameLabel.textColor = [UIColor grayColor];
        _userNameLabel.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_userNameLabel];
        
    }
    return self;
}
@end
