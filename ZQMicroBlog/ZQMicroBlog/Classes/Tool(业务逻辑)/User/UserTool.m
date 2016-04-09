//
//  UserTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "UserTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "MJExtension.h"
#import "UserUnread.h"
#import "Users.h"
@implementation UserTool
+ (void)unreadCountDidsuccess:(void (^)(UserUnread *))success failure:(void (^)(NSError *))failure
{
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [HttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(id responseObject) {
        UserUnread *userUnread = [UserUnread objectWithKeyValues:responseObject];
        if (success) {
            success(userUnread);
        }
                
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
+ (void)userStatus:(void (^)(NSDictionary *dic))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"]= [AccountTool account].access_token;
    params[@"uid"]=[AccountTool account].uid;
    [HttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(id responseObject) {
        NSDictionary *dic=[NSDictionary new];
        dic = responseObject;
        if (success) {
            success(dic);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

}
+ (void)conatcts:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"uid"] = [AccountTool account].uid;
    params[@"count"] = @200;
    [HttpTool get:@"https://api.weibo.com/2/friendships/friends.json" parameters:params success:^(id responseObject) {
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"users"]) {
            Users *user = [Users objectWithKeyValues:dict];
            [users addObject:user];
        }
        if (success) {
            success(users);
        }
        NSLog(@"%ld",users.count);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
