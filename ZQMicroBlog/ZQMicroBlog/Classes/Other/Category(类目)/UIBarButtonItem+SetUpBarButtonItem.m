//
//  UIBarButtonItem+SetUpBarButtonItem.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "UIBarButtonItem+SetUpBarButtonItem.h"

@implementation UIBarButtonItem (SetUpBarButtonItem)
+ (UIBarButtonItem *)barButtonWithImage:(NSString *)image highligthedImage:(NSString *)highImage selector:(SEL)selector target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    CGSize size = [btn imageView].image.size;
    btn.bounds = CGRectMake(0, 0, size.width, size.height);
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
