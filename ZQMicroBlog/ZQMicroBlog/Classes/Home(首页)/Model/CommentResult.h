//
//  CommentResult.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentResult : NSObject
@property (nonatomic, assign) long long total_number;

@property (nonatomic, strong) NSArray *comments;
@end
