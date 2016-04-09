//
//  Users.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Statues;
@interface Users : NSObject
/**
 *  友好显示名称
 */
@property (nonatomic,copy)NSString *name;
/**
 *  用户昵称
 */
@property (nonatomic,copy)NSString *screen_name;
/**
 *  微博的头像
 */
@property (nonatomic,copy)NSURL *profile_image_url;
@property (nonatomic, strong)NSData *imageData;
/**
 *  用户所在地
 */
@property (nonatomic,copy)NSString *location;
/**
 *  用户的个性化域名
 */
@property (nonatomic,copy)NSString *domain;
/**
 *  用户个人描述
 */
@property (nonatomic,copy)NSString *description;
/**
 *  性别
 */
@property (nonatomic,copy)NSString *gender;
/**
 *  字符串型的用户UID
 */
@property (nonatomic,copy)NSString *idstr;
/**
 *  粉丝数
 */
@property (nonatomic,copy)NSString *followers_count;
/**
 *  微博数
 */
@property (nonatomic,copy)NSString *statuses_count;
/**
 *  关注数
 */
@property (nonatomic,copy)NSString *friends_count;
/**
 *  收藏数
 */
@property (nonatomic,copy)NSString *favourites_count;
/**
 *  是否是微博认证用户，即加V用户
 */
@property (nonatomic,copy)NSString *verified;
/**
 *  该用户是否关注当前登录用户
 */
@property (nonatomic,copy)NSString *follow_me;
/**
 *  高清头像原图
 */
@property (nonatomic,copy) NSString *avatar_hd;
/**
 *  用户的最近一条微博信息字段
 */
@property (nonatomic,strong) Statues *status;
@end
/*
 id	int64	用户UID
 province	int	用户所在省级ID
 city	int	用户所在城市ID

 url	string	用户博客地址
 profile_url	string	用户的微博统一URL地址

 weihao	string	用户的微号

 created_at	string	用户创建（注册）时间
 following	boolean	暂未支持
 allow_all_act_msg	boolean	是否允许所有人给我发私信，true：是，false：否
 geo_enabled	boolean	是否允许标识用户的地理位置，true：是，false：否
 verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type	int	暂未支持
 remark	string	用户备注信息，只有在查询用户关系时才返回此字段
 allow_all_comment	boolean	是否允许所有人对我的微博进行评论，true：是，false：否
 avatar_large	string	用户头像地址（大图），180×180像素
 verified_reason	string	认证原因
 online_status	int	用户的在线状态，0：不在线、1：在线
 bi_followers_count	int	用户的互粉数
 lang	string	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */