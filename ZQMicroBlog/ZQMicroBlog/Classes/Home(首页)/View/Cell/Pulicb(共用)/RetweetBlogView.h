//
//  RetweetBlogView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OriginalBlogView.h"
#import <CoreText/CoreText.h>
/**
 *  转发微博类
 */
@class Statues;
@interface RetweetBlogView : UIImageView
/**
 *  转发微博数据模型
 */
@property (nonatomic, strong) Statues *retweeted_status;
/**
 *  转发微博视图的高
 */
@property (nonatomic) CGFloat retweetHeight;
@property (nonatomic, strong) id<BlogCellDelgate>delegate;
- (CGFloat)getHeightFromSubview;
- (void)setRetweeted_status:(Statues *)retweeted_status;
@end
