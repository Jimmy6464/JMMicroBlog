//
//  URLTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "URLTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
@implementation URLTool
+ (void)getLongURlwithShortURL:(NSString *)shortURl success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"url_short"] = shortURl;
    [HttpTool get:@"https://api.weibo.com/2/short_url/expand.json" parameters:params success:^(id responseObject) {
        NSDictionary *urls = responseObject[@"urls"][0];
        NSString *long_url;
        for (NSString *key in urls.allKeys) {
            if ([key isEqualToString:@"url_long"]) {
                long_url = [urls objectForKey:key];
            }
        }
        NSLog(@"%@",long_url);
        if (success) {
            success(long_url);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
