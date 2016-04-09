//
//  AccountTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "AccountTool.h"
#import "HttpTool.h"
#define FileName [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"account.dat"]

@implementation AccountTool

+ (Account *)account
{

    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:FileName];
    if ([account.expires_time compare:[NSDate date]] == NSOrderedAscending) {
        return nil;
    }
    return account;
}
+ (void)saveAccount:(Account *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:FileName];
}
+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(Account *account))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *pramas = [NSMutableDictionary dictionary];
    pramas[@"client_id"] = APPKey;
    pramas[@"client_secret"] = AppSecret;
    pramas[@"grant_type"] = @"authorization_code";
    pramas[@"code"] = code;
    pramas[@"redirect_uri"] = Redirect_uri;

    [HttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:pramas success:^(id responseObject) {
        [AccountTool saveAccount:[Account accountWithDictionary:responseObject]];
        NSLog(@"%@",[AccountTool account]);
        Account *accout = [Account accountWithDictionary:responseObject];
        if (success) {
            success(accout);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
