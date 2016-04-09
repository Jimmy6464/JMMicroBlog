//
//  PhotoesView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/28.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "PhotoesView.h"
#import "SinglePhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define PhotosCount 9
#define Margin 10
const CGFloat photoWH = 70;
@implementation PhotoesView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置所有子控件
        [self setUpAllSubviews];
        
    }
    return self;
}
#pragma mark - 设置所有子控件
- (void)setUpAllSubviews
{
    for (int i = 0; i < PhotosCount; i++) {
        SinglePhotoView *imageV = [[SinglePhotoView alloc]initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapPressed:)];
        [imageV addGestureRecognizer:tap];
        imageV.hidden = YES;
        imageV.tag = i+100;
        [self addSubview:imageV];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpFrame];
}
- (void)setUpFrame
{
    int cols = _pic_urls.count >= 3 ? 3 : 2;
    int j = 0, k = 0;
    CGFloat photoW = (self.frame.size.width - 3*Margin)/cols ;
    for (int i = 0; i < _pic_urls.count; i++,k++) {
        if (i % 3  == 0 && i != 0) {
            j ++;
            k = 0;
        }
        SinglePhotoView *imageV = self.subviews[i];
        imageV.frame = CGRectMake(k * photoW + Margin, j * photoW + Margin, photoW - Margin, photoW - Margin);
        if (i + 1 == _pic_urls.count) {
            SinglePhotoView *imagV = self.subviews[i];
            self.viewH = CGRectGetMaxY(imagV.frame) + Margin * 2;
        }
    }
    
    //
    /*
     int photosCount = (int)_pic_urls.count;
     
     int cols = photosCount == 4?2:3;
     int col = 0;
     int rol = 0;
     CGFloat x = 0;
     CGFloat y = 0;
     for (int i = 0; i < photosCount; i++) {
     col = i % cols;
     rol = i / cols;
     x = col * (Margin + photoWH);
     y = rol * (Margin + photoWH);
     UIImageView *imgV = self.subviews[i];
     imgV.frame = CGRectMake(x, y, photoWH, photoWH);
     
     }
     */
}
#pragma mark - 重写图片数组set方法，同时计算cell的高度
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    for (int i = 0; i < PhotosCount; i++) {
        SinglePhotoView *imageV = self.subviews[i];
        if (i >= pic_urls.count) {
            imageV.hidden = YES;
        }else {
            imageV.photo = self.pic_urls[i];
            imageV.hidden = NO;
        }
    }
    //计算配图view高度
    int cols = _pic_urls.count >= 3 ? 3 : 2;
    CGFloat photoW = (self.frame.size.width - 3*Margin)/cols ;
    if (_pic_urls.count > 6) {
        self.viewH = 3 * (photoW + Margin);
    }else if (_pic_urls.count > 3){
        self.viewH = 2 * (photoW + Margin);
    }else {
        self.viewH = photoW + Margin;
    }
}
#pragma mark - 图片点击事件
- (void)imageTapPressed:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s",__func__);
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = tap.view.tag - 100;
    NSMutableArray *photos = [NSMutableArray array];
    
    for (Photoes *photo in _pic_urls) {
        
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = photo.large_pic;
        
        mjPhoto.srcImageView = (UIImageView *)tap.view;

        [photos addObject:mjPhoto];
    }
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];

}
@end
