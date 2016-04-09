//
//  HttpTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
@implementation HttpTool
/**
 *  get请求
 *
 *  @param url     基本url
 *  @param params  参数
 *  @param success 获取请求的数据
 *  @param failure 失败请求
 */
+ (void)get:(NSString *)url parameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)post:(NSString *)url parameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
