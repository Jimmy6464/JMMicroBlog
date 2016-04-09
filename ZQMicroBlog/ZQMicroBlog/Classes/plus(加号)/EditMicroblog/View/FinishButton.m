//
//  FinishButton.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "FinishButton.h"

@implementation FinishButton
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 50*0.9, 25*0.9);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor orangeColor];
        self.layer.cornerRadius = 3.0;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return self;
}
-(void)setSelfEnabled:(BOOL)enabled
{
    if (enabled == YES) {
        self.layer.borderWidth = 0;
        self.backgroundColor = [UIColor orangeColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.enabled = enabled ;
    }
    else
    {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        self.enabled = enabled ;
    }
}
@end
