//
//  Statues.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Users.h"
@interface Statues : NSObject
/**
 *  用户
 */
@property (nonatomic,strong)Users *user;
/**
 *  转发的微博
 */
@property (nonatomic,strong)Statues *retweeted_status;
/**
 *  微博创建时间
 */
@property (nonatomic,copy)NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic,copy)NSString *idstr;
@property (nonatomic,assign) NSInteger id;
/**
 *  微博信息内容
 */
@property (nonatomic,copy)NSString *text;
/**
 *  微博来源
 */
@property (nonatomic,copy)NSString *source;
/**
 *  表态数
 */
@property (nonatomic)int attitudes_count;
/**
 *  转发数
 */
@property (nonatomic)int reposts_count;
/**
 *  评论数
 */
@property (nonatomic)int comments_count;

/**
 *  配图数组（模型）
 */
@property (nonatomic,strong)NSArray *pic_urls;
@property (nonatomic, strong) NSURL *bmiddle_pic;
@end
