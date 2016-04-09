//
//  CommentCacheTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/10.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentParams;
@interface CommentCacheTool : NSObject
+ (void)saveWithComments:(NSArray *)dictArr;
+ (NSArray *)commentsWithParam:(CommentParams *)params;
@end
