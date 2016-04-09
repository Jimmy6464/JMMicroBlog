//
//  RetweetDetailView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "RetweetBlogView.h"
@class Statues;
@interface RetweetDetailView : UIImageView
@property (nonatomic, strong) Statues *retweeted_status;
@property (nonatomic) CGFloat retweetHeight;
@end
