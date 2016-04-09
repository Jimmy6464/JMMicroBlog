//
//  UserTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserUnread;
@interface UserTool : NSObject
+ (void)unreadCountDidsuccess:(void (^)(UserUnread *unRead))success failure:(void (^)(NSError *error))failure;
+ (void)userStatus:(void (^)(NSDictionary *dic))success failure:(void (^)(NSError *error))failure;
+ (void)conatcts:(void (^)(NSArray *contacts))success failure:(void (^)(NSError *error))failure;
@end
