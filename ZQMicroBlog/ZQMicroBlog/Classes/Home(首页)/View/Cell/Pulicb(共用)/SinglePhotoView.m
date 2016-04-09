//
//  SinglePhotoView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/28.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "SinglePhotoView.h"
#import "UIImageView+WebCache.h"
@interface SinglePhotoView ()
/**
 *  gif图标
 */
@property (nonatomic,strong) UIImageView *gifView;
/**
 *  长图图标
 */
@property (nonatomic,strong) UIImageView *longPicView;

@end
@implementation SinglePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:imageview];
        _gifView = imageview;
    }
    return _gifView;
}
- (UIImageView *)longPicView
{
    if (_longPicView == nil) {
        UIImageView *longImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_longimage"]];
        [self addSubview:longImage];
        _longPicView = longImage;
    }
    return _longPicView;
}
- (void)setPhoto:(Photoes *)photo
{
    _photo = photo;
    if ([_photo.thumbnail_pic.absoluteString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
        [self sd_setImageWithURL:_photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
    }else {
        self.gifView.hidden = YES;
        [self sd_setImageWithURL:_photo.bmiddle_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect gifRect = self.gifView.frame;
    CGRect rect = self.frame;
    self.gifView.frame = CGRectMake(rect.size.width - gifRect.size.width, rect.size.height - gifRect.size.height, gifRect.size.width, gifRect.size.height);
}
@end
