//
//  CommentResult.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "CommentResult.h"
#import "MJExtension.h"
#import "Comment.h"
@implementation CommentResult
- (NSDictionary *)objectClassInArray
{
    return @{@"comments":[Comment class]};
}
@end
