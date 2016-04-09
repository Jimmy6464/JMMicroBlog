//
//  StatusesTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "StatusesTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "StatuesResult.h"
#import "Statues.h"
#import "StatusParams.h"
#import "StatusCacheTool.h"

static NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
@implementation StatusesTool
+ (void)loadNewBlodWithSinceID:(id)ID success:(void (^)(NSArray *status))success failure:(void (^)(NSError *error))failure
{
    /*
     NSMutableDictionary *parames = [NSMutableDictionary dictionary];
     parames[@"access_token"] = [AccountTool account].access_token;
     if (ID) {
     parames[@"since_id"] = ID;
     }
     [HttpTool get:urlString parameters:parames success:^(id responseObject) {
     NSMutableArray *status = [NSMutableArray array];
     //添加新数据
     StatuesResult *result = [StatuesResult objectWithKeyValues:responseObject];
     
     for (NSDictionary *dict in responseObject[@"statuses"]) {
     Statues *staues = [Statues objectWithKeyValues:dict];
     [status addObject:staues];
     }
     [result.keyValues writeToFile:CurrentPath(@"statuses.plist") atomically:YES];
     NSLog(@"%@",CurrentPath(@"statuses.plist"));
     if (success) {
     success(status);
     }
     
     } failure:^(NSError *error) {
     if (failure) {
     failure(error);
     }
     }];

     */
        // 拼接参数
    StatusParams *param = [[StatusParams alloc] init];
    param.access_token = [AccountTool account].access_token;
    param.since_id = ID;
    
#warning  先从缓存中获取数据
    //    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
    //    if (statuses.count) {
    //
    //        NSMutableArray *arrM = [NSMutableArray array];
    //        for (IWStatus *status in statuses) {
    //            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
    //            statusF.status = status;
    //            [arrM addObject:statusF];
    //        }
    //        if (success) {
    //            success(arrM);
    //        }
    //
    //        // 不需要在发送请求
    //        return;
    //    }
    
    
    // 发送请求
    [HttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
#warning  存储数据
        [StatusCacheTool saveWithStatus:responseObject[@"statuses"]];
        
        StatuesResult *result = [StatuesResult objectWithKeyValues:responseObject];
        
        NSDictionary *plist = result.keyValues;
        [plist writeToFile:@"/Users/yuanzheng/Desktop/status.plist" atomically:YES];
        
        
        NSMutableArray *status = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject[@"statuses"]) {
            Statues *staues = [Statues objectWithKeyValues:dict];
            [status addObject:staues];
        }
        if (success) {
            success(status);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (void)loadMoreBlodWithMaxID:(id)ID success:(void (^)(NSArray *status))success failure:(void (^)(NSError *error))failure
{

     // 拼接参数
     StatusParams *param = [[StatusParams alloc] init];
     param.access_token = [AccountTool account].access_token;
     param.max_id = ID;
     
     // 加载缓存数据
     NSArray *statuses =  [StatusCacheTool statusesWithParam:param];
     if (statuses.count) {
         if (success) {
             success(statuses);
         }
         // 不需要在发送请求
         return;
     }
    // 发送请求
    [HttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 存储数据
        [StatusCacheTool saveWithStatus:responseObject[@"statuses"]];
        
//        StatuesResult *result = [StatuesResult objectWithKeyValues:responseObject];
        
        NSMutableArray *status = [NSMutableArray array ];
        for (NSDictionary *dict in responseObject[@"statuses"]) {
            Statues *staues = [Statues objectWithKeyValues:dict];
            [status addObject:staues];
        }
        if (success) {
            success(status);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    /*
     NSMutableDictionary *parames = [NSMutableDictionary dictionary];
     parames[@"access_token"] = [AccountTool account].access_token;
     if (ID) {
     parames[@"max_id"] = ID;
     }
     [HttpTool get:urlString parameters:parames success:^(id responseObject) {
     NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(@"statuses.plist")];
     //添加新数据
     StatuesResult *result = [StatuesResult objectWithKeyValues:responseObject];
     [dict[@"statuses"] addObjectsFromArray:result.keyValues[@"statuses"]];
     [dict writeToFile:CurrentPath(@"statuses.plist") atomically:YES];
     
     
     NSMutableArray *status = [NSMutableArray array ];
     for (NSDictionary *dict in responseObject[@"statuses"]) {
     Statues *staues = [Statues objectWithKeyValues:dict];
     [status addObject:staues];
     }
     
     NSLog(@"%@",CurrentPath(@"statuses.plist"));
     
     if (success) {
     success(status);
     }
     
     } failure:^(NSError *error) {
     if (failure) {
     failure(error);
     }
     }];
     */
}
@end
