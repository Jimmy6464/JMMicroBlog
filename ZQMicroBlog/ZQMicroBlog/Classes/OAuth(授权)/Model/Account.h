//
//  Account.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
/**
*  令牌
*/
@property (nonatomic, copy)NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy)NSString *expires_in;
@property (nonatomic, copy)NSString *remind_in;
/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSDate *expires_time;


+ (instancetype)accountWithDictionary:(NSDictionary *)dict;
@end
