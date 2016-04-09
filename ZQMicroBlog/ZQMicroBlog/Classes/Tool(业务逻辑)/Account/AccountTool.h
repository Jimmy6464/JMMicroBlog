//
//  AccountTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
@interface AccountTool : NSObject
+ (Account *)account;
+ (void)saveAccount:(Account *)account;
+ (void)accessTokenWithCode:(NSString *)code success:(void(^)(Account *account)) success failure:(void(^)(NSError *error)) failure;
@end
