//
//  HttpTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+ (void)get:(NSString *)url parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
