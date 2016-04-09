//
//  TitleView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "TitleView.h"
#define IWMarginX 5
#define IWMarginY 13
@implementation TitleView
- (UIButton *)editGroudButton
{
    if (_editGroudButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"编辑我的分组" forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.highlightedTextColor = [UIColor orangeColor];
        btn.layer.borderWidth = 0.1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setBackgroundImage:[UIImage resizableWithImageName:@"popover_noarrow_background"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(editGroudButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:btn];
        _editGroudButton = btn;
    }
    return _editGroudButton;
}
- (UIImageView *)backgroundView
{
    if (_backgroundView == nil) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage resizableWithImageName:@"popover_background"]];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _backgroundView = imageView;
    }
    return _backgroundView;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    [self.backgroundView addSubview:contentView];
}
- (void)showTitleViewInRect:(CGRect)frame
{
    self.backgroundView.frame = frame;
    [KeyWindow addSubview:self];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    [_delegate removeTitleView:self];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = _backgroundView.frame.size;
    CGFloat x = IWMarginX;
    CGFloat y = IWMarginY;
    CGFloat w = size.width - IWMarginX * 2;
    CGFloat h = size.height - IWMarginY * 2 - 30;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
    //设置按钮
    self.editGroudButton.frame = CGRectMake(10, size.height - 40, size.width - 20, 30);

}
- (void)editGroudButtonPressed:(UIButton *)btn
{
    NSLog(@"%s",__func__);
}
@end
