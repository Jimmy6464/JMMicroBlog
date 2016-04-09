//
//  OriginalBlogView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statues.h"
#import "BlogCellDelgate.h"

/**
 *  原创微博类
 */
@interface OriginalBlogView : UIView
/**
 *  原创微博数据模型
 */
@property (nonatomic, strong) Statues *status;
@property (nonatomic, weak) id<BlogCellDelgate> delgate;
@property (nonatomic) CGFloat originalH;
@end
