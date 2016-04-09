//
//  SelfBarBtnItem.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "SelfBarBtnItem.h"

@implementation SelfBarBtnItem
-(instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    if (self = [super init]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        self = (SelfBarBtnItem *)[[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    return self;
}
@end
