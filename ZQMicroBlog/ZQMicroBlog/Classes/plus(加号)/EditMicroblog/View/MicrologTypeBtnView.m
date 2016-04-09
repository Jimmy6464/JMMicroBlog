//
//  MicrologTypeBtnView.m
//  dasdas
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//
#import "TypeBtnView.h"
#import "MicrologTypeBtnView.h"
@interface MicrologTypeBtnView()
{
    UIButton *_addBtn;
    UIToolbar *_toolbar;
    UIBarButtonItem *_addBtnItem;
}
@end
@implementation MicrologTypeBtnView
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 375, 667);
        self.backgroundColor = [UIColor whiteColor];
        [self initImageView];
        [self initScrollerView];
        [self initToolBar];
    }
    return self;
}

-(void)initToolBar
{
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 667-44, 375, 44)];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(0, 0, 50, 50);
    [_addBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
    [_addBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    _addBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_addBtn];
    _addBtnItem.width = 344;
    toolbar.items = @[_addBtnItem];
     [self addSubview:toolbar];
    
    _toolbar = toolbar;
}

-(void)initImageView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    imageView.frame = CGRectMake(100, 100, 154*1.2, 48*1.2);
    [self addSubview:imageView];
}
-(void)initScrollerView
{
    _typeBtnScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 375, 667-200)];
    _typeBtnScrollerView.pagingEnabled = YES;
    _typeBtnScrollerView.scrollEnabled = YES;
    _typeBtnScrollerView.bounces = NO ;
    _typeBtnScrollerView.delegate = self ;
    [self initPageOne];
    [self addSubview:_typeBtnScrollerView];
}

-(void)initPageTwo
{
    [self addReturnBtnToToolBar];
    _typeBtnScrollerView.contentSize = CGSizeMake(375*2, 667-200);
    _pageTwo = [[UIView alloc]initWithFrame:CGRectMake(375 , 0, 375, 667-200)];
    _pageTwo.backgroundColor = [UIColor clearColor];
    
    TypeBtnView *friendBtnView = [[TypeBtnView alloc]initWithNum:6 andImage:[UIImage imageNamed:@"tabbar_compose_friend"] andText:@"好友圈"];
    TypeBtnView *locationBtnView = [[TypeBtnView alloc]initWithNum:8 andImage:[UIImage imageNamed:@"tabbar_compose_music"] andText:@"音乐"];
    TypeBtnView *remarkBtnView = [[TypeBtnView alloc]initWithNum:9 andImage:[UIImage imageNamed:@"tabbar_compose_productrelease"] andText:@"商品"];
    TypeBtnView *wbcameraBtnView = [[TypeBtnView alloc]initWithNum:7 andImage:[UIImage imageNamed:@"tabbar_compose_wbcamera"] andText:@"微博相机"];
    [_pageTwo addSubview:friendBtnView];
    [_pageTwo addSubview:locationBtnView];
    [_pageTwo addSubview:remarkBtnView];
    [_pageTwo addSubview:wbcameraBtnView];
    [_typeBtnScrollerView addSubview:_pageTwo];
    [UIView animateWithDuration:0.4 animations:^{
        [_typeBtnScrollerView setContentOffset:CGPointMake(375, 0)];
    } completion:nil];
    
}

-(void)addReturnBtnToToolBar
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 50, 50);
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    addBtnItem.width = 375/2;
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 0, 50, 50);
    [returnBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:UIControlStateHighlighted];
    [returnBtn addTarget:self action:@selector(returnToPageOne) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    returnBtnItem.width = 370/2;
    
    UIBarButtonItem *span = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIView *cutView = [[UIView alloc]initWithFrame:CGRectMake(374/2, 0, 1, 44)];
    cutView.backgroundColor = [UIColor lightGrayColor];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 667-44, 375, 44)];
    toolbar.items = @[returnBtnItem,span,addBtnItem];
    toolbar.tag = 20001;
    [toolbar addSubview:cutView];
    [self addSubview:toolbar];
}

-(void)returnToPageOne
{
    
    [UIView animateWithDuration:0.4 animations:^{
        [_typeBtnScrollerView setContentOffset:CGPointMake(1, 0)];
//        UIToolbar *toolbar = (UIToolbar *)[self viewWithTag:20001];
//        toolbar.alpha = 0 ;
    } completion:^(BOOL finished) {
        [_typeBtnScrollerView setContentOffset:CGPointMake(0, 0)];
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIToolbar *toolbar = (UIToolbar *)[self viewWithTag:20001];
    toolbar.alpha = 1-(1.0/375.0)*(375-_typeBtnScrollerView.contentOffset.x) ;
    if (_typeBtnScrollerView.contentOffset.x == 0) {
        [self deletePageTow];
    }
}
-(void)deletePageTow
{
    UIToolbar *toolbar = (UIToolbar *)[self viewWithTag:20001];
    [toolbar removeFromSuperview];
    [_pageTwo removeFromSuperview];
    _pageTwo = nil;
    _typeBtnScrollerView.contentSize = CGSizeMake(375, 667-200);
}

-(void)initPageOne
{
    _pageOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 667-200)];
    _pageOne.backgroundColor = [UIColor clearColor];
    
    TypeBtnView *baseMicrologEditBtnView = [[TypeBtnView alloc]initWithNum:0 andImage:[UIImage imageNamed:@"tabbar_compose_idea"] andText:@"文字"];
    TypeBtnView *getPhotoBtnView = [[TypeBtnView alloc]initWithNum:1 andImage:[UIImage imageNamed:@"tabbar_compose_photo"] andText:@"照片/视频"];
    TypeBtnView *editLongMicrologBtnView = [[TypeBtnView alloc]initWithNum:2 andImage:[UIImage imageNamed:@"tabbar_compose_weibo"] andText:@"长微博"];
    TypeBtnView *locationBtnView = [[TypeBtnView alloc]initWithNum:3 andImage:[UIImage imageNamed:@"tabbar_compose_lbs"] andText:@"签到"];
    TypeBtnView *remarkBtnView = [[TypeBtnView alloc]initWithNum:4 andImage:[UIImage imageNamed:@"tabbar_compose_review"] andText:@"点评"];
    TypeBtnView *moreBtnView = [[TypeBtnView alloc]initWithNum:5 andImage:[UIImage imageNamed:@"tabbar_compose_more"] andText:@"更多"];
    
    [_pageOne addSubview:baseMicrologEditBtnView];
    [_pageOne addSubview:getPhotoBtnView];
    [_pageOne addSubview:editLongMicrologBtnView];
    [_pageOne addSubview:locationBtnView];
    [_pageOne addSubview:remarkBtnView];
    [_pageOne addSubview:moreBtnView];
    [_typeBtnScrollerView addSubview:_pageOne];
}

-(void)closeSelf
{
    [UIView animateWithDuration:0.4 animations:^{
        CGAffineTransform t = _addBtn.transform;
        _addBtn.transform = CGAffineTransformRotate(t, -3.14/4);
    } completion:nil];
    
    NSArray *typeBtnViewArr = [_pageOne subviews];
    for (UIView *tbv in typeBtnViewArr) {
        if ([tbv isKindOfClass:[TypeBtnView class]]) {
            TypeBtnView *typeB = (TypeBtnView *)tbv;
            [UIView animateWithDuration:0.45-0.05*typeB.num animations:^{
                typeB.alpha = 1;
                typeB.frame = CGRectMake(typeB.frame.origin.x, typeB.frame.origin.y+125*3, typeB.frame.size.width, typeB.frame.size.height);
                typeB.transform = CGAffineTransformMakeScale(0.2, 0.2);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    if (_pageTwo != nil) {
        
        NSArray *typeBtnViewArr2 = [_pageTwo subviews];
        for (UIView *tbv in typeBtnViewArr2) {
            if ([tbv isKindOfClass:[TypeBtnView class]]) {
                TypeBtnView *typeB = (TypeBtnView *)tbv;
                [UIView animateWithDuration:0.45-0.05*(typeB.num-6) animations:^{
                    typeB.alpha = 1;
                    typeB.frame = CGRectMake(typeB.frame.origin.x, typeB.frame.origin.y+125*3, typeB.frame.size.width, typeB.frame.size.height);
                    typeB.transform = CGAffineTransformMakeScale(0.2, 0.2);
                } completion:^(BOOL finished) {
                    [self deletePageTow];
                }];
            }
        }
    }
    
    
    [self performSelector:@selector(hideSelf) withObject:nil afterDelay:0.45];
}
-(void)hideSelf
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0 ;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
-(void)closeStatic
{
    CGAffineTransform t = _addBtn.transform;
    _addBtn.transform = CGAffineTransformRotate(t, -3.14/4);
    NSArray *typeBtnViewArr = [_pageOne subviews];
    for (UIView *tbv in typeBtnViewArr) {
        if ([tbv isKindOfClass:[TypeBtnView class]]) {
            TypeBtnView *typeB = (TypeBtnView *)tbv;
            typeB.frame = CGRectMake(typeB.frame.origin.x, typeB.frame.origin.y+125*3, typeB.frame.size.width, typeB.frame.size.height);
            typeB.transform = CGAffineTransformMakeScale(0.2, 0.2);
        }
    }
}
-(void)showSelf
{
    _addBtn.transform = CGAffineTransformRotate(_addBtn.transform, 0);
    self.hidden = NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1 ;
    } completion:nil];
    
    [UIView animateWithDuration:0.4 animations:^{
        _addBtn.transform = CGAffineTransformRotate(self.transform, 3.14/4);
    } completion:nil];
    
    NSArray *typeBtnViewArr = [_pageOne subviews];
    for (UIView *tbv in typeBtnViewArr) {
        if ([tbv isKindOfClass:[TypeBtnView class]]) {
            TypeBtnView *typeB = (TypeBtnView *)tbv;
            [UIView animateWithDuration:0.4+0.05*typeB.num animations:^{
                typeB.alpha = 1;
                typeB.frame = CGRectMake(typeB.frame.origin.x, typeB.frame.origin.y-125*3, typeB.frame.size.width, typeB.frame.size.height);
                typeB.transform = CGAffineTransformMakeScale(1, 1);
            } completion:nil];
        }
    }
}
@end
