//
//  CommentTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentTool : NSObject
+ (void)loadNewCommentWithParams:(id)params success:(void (^)(NSArray *comments))success failure:(void (^)(NSError *error))failure;
+ (void)loadMoreCommentWithParams:(id)params success:(void (^)(NSArray *comments))success failure:(void (^)(NSError *error))failure;
@end
