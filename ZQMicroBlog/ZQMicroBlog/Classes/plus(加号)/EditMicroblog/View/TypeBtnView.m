//
//  TypeBtnView.m
//  dasdas
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TypeBtnView.h"
@interface TypeBtnView()
{
    UIImageView *_imageView;
}


@end


@implementation TypeBtnView

-(instancetype)initWithNum:(NSInteger)num andImage:(UIImage *)image andText:(NSString *)text
{
    if (self = [super init]) {
//        self.backgroundColor = [UIColor yellowColor];
        _num = num ;
        if (num > 5) {
            num = num - 6*(num / 6) ;
        }
        self.frame = CGRectMake((num%3) * 125 , (num/3)*125 + 50, 125, 125);
        self.tag = 10001;
        [self initTypeLabelWithText:text];
        [self initTypeBtnWithImage:image];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beSmallDisAppear:) name:@"disAppear" object:nil];
        
    }
    return  self;
}
-(void)initTypeBtnWithImage:(UIImage *)image
{
    _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeBtn.frame = CGRectMake(0, 0, 125, 125);
    
    _imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat w = 80 ;
    CGFloat x = (_typeBtn.frame.size.width - w)/2 ;
    CGFloat y = (_typeBtn.frame.size.height  - _typeLabel.frame.size.height - w )/2;
    _imageView.frame = CGRectMake(x, y, w, w);
    
    [_typeBtn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [_typeBtn addTarget:self action:@selector(pushToNextViewController) forControlEvents:UIControlEventTouchUpInside];
    [_typeBtn addTarget:self action:@selector(touchDragInside) forControlEvents:UIControlEventTouchDragInside];
    
    [_typeBtn addSubview:_imageView];
    
    [self addSubview:_typeBtn];
    
}
-(void)pushToNextViewController
{
    if (self.tag != 10002 ) {
        if (_num == 5) {
            [self performSelector:@selector(touchDragInside) withObject:nil afterDelay:0.05];
            [self performSelector:@selector(nextPage) withObject:nil afterDelay:0.05];
        }
        else
        {
            //发送消息通知其他按钮变小消失
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInteger:_num],@"num", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"disAppear" object:nil userInfo:dic];
            
            [self beBigDisAppear];
            
            [self performSelector:@selector(pushToSelfViewController) withObject:nil afterDelay:0.55];
        }
    }
    else
    {
        self.tag = 10001;
    }
    
}
-(void)pushToSelfViewController
{
    switch (_num) {
        case 0:
            [self.tbDelegate pushToBaseMicroblogEditController];
            break;
        case 1:
            [self.tbDelegate pushToGetPhotoController];
            break;
        case 2:
            [self.tbDelegate pushToEditLongMicrologController];
            break;
        case 3:
            [self.tbDelegate pushToLocationController];
            break;
        case 4:
            [self.tbDelegate pushToRemarkMicrologController];
            break;
        case 6:
            break;
        default:
            break;
    }
}
-(void)nextPage
{
    self.tag = 10001;
    [self.tbDelegate gotoNextPage];
    
}
-(void)beSmallDisAppear:(NSNotification *)nf
{
    NSDictionary *dic = [nf userInfo];
    NSInteger num = [[dic objectForKey:@"num"] integerValue];
    if (_num != num) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(0.4, 0.4);
            self.alpha = 0 ;
        } completion:^(BOOL finished) {
            [self stopAction];
        }];
        
    }
}

-(void)stopAction
{
    [self.layer removeAllAnimations];
}



//使按钮放大淡化消失
-(void)beBigDisAppear
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0 ;
    } completion:^(BOOL finished) {
        [self stopAction];
    }];
}

-(void)touchDragInside
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    _imageView.transform  = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    self.tag = 10002;
    
}
-(void)touchDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    _imageView.transform  = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView commitAnimations];
}
//初始化类型名
-(void)initTypeLabelWithText:(NSString *)text
{
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 108, 125, 12)];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    _typeLabel.text = text;
    _typeLabel.textColor = [UIColor blackColor];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_typeLabel];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"disAppear" object:nil];
}
@end
