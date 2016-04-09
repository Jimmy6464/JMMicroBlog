//
//  BaseTextView.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/8.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "BaseTextView.h"
@interface BaseTextView()
{
    SelfKeyBroad *_keyBroadView;
}
@end
@implementation BaseTextView
#define  screenH  [UIScreen mainScreen].bounds.size.height
#define  screenW  [UIScreen mainScreen].bounds.size.width

-(void)initSelfKB
{
    _keyBroadView = [[SelfKeyBroad alloc]initWithFrame:CGRectMake(0,200, 375, 667 - 200 )];
    _keyBroadView.owner = self;
    _keyBroadView.kbDelegate = self;
    [self addSubview:_keyBroadView];
}
//-(void)setDefaultProperty
//{
//    self.delegate = self;
//    self.scrollEnabled = NO;
//    self.backgroundColor = [UIColor whiteColor];
//    self.font = [UIFont systemFontOfSize:20];
//    [self addGestuerToTextView];
//    
//    _placeHolder = [[UILabel alloc]initWithFrame:CGRectMake(10, 15 , 100, 15)];
//    _placeHolder.text = @"分享新鲜事...";
//    _placeHolder.font = [UIFont systemFontOfSize:20.0];
//    _placeHolder.textColor = [UIColor lightGrayColor];
//    [self addSubview:_placeHolder];
//}
//-(void)addGestuerToTextView
//{
//    UISwipeGestureRecognizer *sw = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swAction)];
//    sw.direction = UISwipeGestureRecognizerDirectionDown;
//    [_textView addGestureRecognizer:sw];
//    
//    UISwipeGestureRecognizer *sw2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swAction)];
//    sw.direction = UISwipeGestureRecognizerDirectionUp;
//    [_textView addGestureRecognizer:sw2];
//    
//}
@end
