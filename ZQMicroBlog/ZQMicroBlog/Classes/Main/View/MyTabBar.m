//
//  MyTabBar.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MyTabBar.h"
#import "MyTabBarButton.h"
@interface MyTabBar()
/**
 *  加号按钮
 */
@property (nonatomic, strong)UIButton *plusButton;
@property (nonatomic, strong)UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *tabBarbuttons;
@end

@implementation MyTabBar
#pragma mark - 1.懒加载
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(plusButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        _plusButton = button;
        
    }
    return _plusButton;
}

- (NSMutableArray *)tabBarbuttons
{
    if (_tabBarbuttons == nil) {
        NSMutableArray *btns = [NSMutableArray array];
        _tabBarbuttons = btns;
    }
    return _tabBarbuttons;
}
#pragma mark - 2.设计布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.设置barItems的位置
    [self setUpItemsFrame];
    //2.设置加号的位置
    [self setupPlusButtonFrame];
}
#pragma mark - 3.设置barItem的位置
- (void)setUpItemsFrame
{
    //获取tabBar上的按钮的总数
    NSInteger count = self.tabBarbuttons.count + 1;
    CGFloat btnWidth = self.frame.size.width/count;
    CGFloat btnHeight = self.frame.size.height;
    
    NSInteger i = 0;
    for (UIView *tabBarItem in _tabBarbuttons) {
        if (i == 2) {
            i += 1;
        }
        tabBarItem.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
        i++;
    }
}
#pragma mark - 4.设置加号的位置
- (void)setupPlusButtonFrame
{
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height * 0.5;
    CGSize size = [self.plusButton backgroundImageForState:UIControlStateNormal].size;
    self.plusButton.frame = CGRectMake(_plusButton.frame.origin.x, _plusButton.frame.origin.y, size.width, size.height);
    self.plusButton.center = CGPointMake(centerX, centerY);
    
}
- (void)addItemToTabBarButtos:(UITabBarItem *)item
{
    MyTabBarButton *myBtn  = [MyTabBarButton buttonWithType:UIButtonTypeCustom];
    myBtn.item = item;
    [myBtn addTarget:self action:@selector(myBtnClick:) forControlEvents:UIControlEventTouchDown];
    myBtn.tag = self.tabBarbuttons.count;
    [self addSubview:myBtn];
    if (self.tabBarbuttons.count == 0) {
        [self myBtnClick:myBtn];
    }
    [self.tabBarbuttons addObject:myBtn];
}
- (void)myBtnClick:(MyTabBarButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    //用途取消选中
    _selectedButton = button;
    
    if ([_tbDelegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]) {
        [_tbDelegate tabBar:self didSelectedIndex:button.tag];
    }
}

#pragma mrak - 加号点击事件
- (void)plusButtonAction
{
    [self.tbDelegate plusButtonAction];
}

@end
