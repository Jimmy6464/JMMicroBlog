//
//  Comment.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Users.h"
#import "Statues.h"
@interface Comment : NSObject
/**
 *  评论创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  评论的内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  评论的内容
 */
@property (nonatomic, copy) NSString *source;
/**
 *  字符串型的评论ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  评论的ID
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */
@property (nonatomic, strong) Comment *reply_comment;
/**
 *  评论作者的用户信息字段
 */
@property (nonatomic, strong) Users *user;
/**
 *  评论的微博信息字段
 */
@property (nonatomic, strong) Statues *status;
/*
 返回值字段	字段类型	字段说明
 created_at	string	评论创建时间
 id	int64	评论的ID
 text	string	评论的内容
 source	string	评论的来源
 user	object	评论作者的用户信息字段 详细
 mid	string	评论的MID
 idstr	string	字符串型的评论ID
 status	object	评论的微博信息字段 详细
 reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */
@end
