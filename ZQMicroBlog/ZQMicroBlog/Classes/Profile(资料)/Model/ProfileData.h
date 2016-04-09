//
//  ProfileData.h
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileData : NSObject
@property(assign,nonatomic)NSInteger ID;
@property(strong,nonatomic)NSString *screen_name;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *location;
@property(strong,nonatomic)NSString *Description;
@property(strong,nonatomic)NSData *avatar_largeData;//头像大图
@property(assign,nonatomic)NSInteger followers_count;//粉丝数
@property(assign,nonatomic)NSInteger friends_count;//关注数
@property(assign,nonatomic)NSInteger statuses_count;//评论数
@property(strong,nonatomic)NSString *gender;//性别

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(id)StutasWithDictionary:(NSDictionary *)dictionary;

@end
