//
//  FWBMessage.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWBMessage : NSObject
//created_at	string	评论创建时间
//id	int64	评论的ID
//text	string	评论的内容
//source	string	评论的来源
//user	object	评论作者的用户信息字段 详细
//mid	string	评论的MID
//idstr	string	字符串型的评论ID
//status	object	评论的微博信息字段 详细
//reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSDictionary *user;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSDictionary *status;
@property(nonatomic,copy)NSDictionary *reply_comment;
@property(nonatomic,copy)NSDictionary *retweeted_status;
@property(nonatomic,strong)NSData *profileImageData;
@property(nonatomic,assign)NSInteger attitudes_count;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(id)StutasWithDictionary:(NSDictionary *)dictionary;

@end
