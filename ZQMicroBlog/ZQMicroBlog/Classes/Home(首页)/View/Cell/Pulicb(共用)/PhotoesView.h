//
//  PhotoesView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/28.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  配图类
 */
@interface PhotoesView : UIView
/**
 *  图片数组
 */
@property (nonatomic,strong) NSArray *pic_urls;
@property (nonatomic) CGFloat viewH;
@end
