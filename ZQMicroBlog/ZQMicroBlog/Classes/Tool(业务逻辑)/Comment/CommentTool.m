//
//  CommentTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "CommentTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "Comment.h"
#import "CommentResult.h"
#import "CommentCacheTool.h"
static NSString *url = @"https://api.weibo.com/2/comments/show.json";
@implementation CommentTool
+ (void)loadNewCommentWithParams:(id)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    [HttpTool get:url parameters:params success:^(id responseObject) {
        NSMutableArray *comments = [NSMutableArray array];
        //添加新数据
        CommentResult *result = [CommentResult objectWithKeyValues:responseObject];
        [CommentCacheTool saveWithComments:responseObject[@"comments"]];
        for (NSDictionary *dict in responseObject[@"comments"]) {
            Comment *comment = [Comment objectWithKeyValues:dict];
            [comments addObject:comment];
        }
        [result.keyValues writeToFile:CurrentPath(@"comments.plist") atomically:YES];
        NSLog(@"%@",CurrentPath(@"comments.plist"));
        if (success) {
            success(comments);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)loadMoreCommentWithParams:(id)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    [HttpTool get:url parameters:params success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
