//
//  FWBNewFeattureCell.m
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/4.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//
#import "MainController.h"
#import "FWBNewFeattureCell.h"
@interface FWBNewFeattureCell()
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,weak)UIButton *shareButton;
@property (nonatomic,weak)UIButton *startBtn;
@end
static NSString *cell = @"cell";
static UICollectionView *_collectionView = nil;
@implementation FWBNewFeattureCell
- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        _shareButton = btn;
    }
    return _shareButton;
}
- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startBtn = startBtn;
    }
    return _startBtn;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc]init];
        _imageView = imageV;
        //注意：一定要加载到contentView;
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
#pragma mark - 
- (void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
- (void)start
{
    //进入首页
    MainController *tabbar = [MainController new];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
}

//布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    _shareButton.center = CGPointMake(self.frame.size.width* 0.5, self.frame.size.height * 0.75);
    _startBtn.center = CGPointMake(self.frame.size.width* 0.5, self.frame.size.height * 0.85);
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image;
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    // 注册UICollectionViewCell
    if (_collectionView == nil) {
        _collectionView = collectionView;
        [collectionView registerClass:[FWBNewFeattureCell class] forCellWithReuseIdentifier:cell];
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:cell forIndexPath:indexPath];
}
- (void)setIndexPath:(NSIndexPath *)indexPath pagecount:(NSInteger)pagecount
{
    if (indexPath.row == pagecount - 1) { // 最后一页
        // 添加分享
        [self shareButton];
        // 添加开始微博
        [self startBtn];
    }
}
@end
