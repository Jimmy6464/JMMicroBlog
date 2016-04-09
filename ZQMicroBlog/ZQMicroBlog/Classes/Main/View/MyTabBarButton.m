//
//  MyTabBarButton.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MyTabBarButton.h"
#define Margin 5
@implementation MyTabBarButton
/**
 *  懒加载
 *
 *  @return badgeView
 */
- (MyBadgeView *)badgeView
{
    if (_badgeView == nil) {
        MyBadgeView *badgeView = [MyBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        _badgeView = badgeView;
    }
    return _badgeView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}
#pragma mark - 重写set方法赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    //设置背景与标题
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    self.badgeView.badgeValue = item.badgeValue;
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.badgeView.badgeValue = _item.badgeValue;
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
}
- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
}
#pragma mark - 设置按钮frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width;
    CGFloat imageH = btnH *0.7;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    CGFloat titleH = btnH - imageH;
    CGFloat titleY = imageH - 2;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    //设置小加点的frame
    CGFloat badgeViewX = self.frame.size.width - self.badgeView.frame.size.width- Margin;
    self.badgeView.frame = CGRectMake(badgeViewX, 0,_badgeView.frame.size.width,_badgeView.frame.size.height);

}
@end
