//
//  StatusesTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusesTool : NSObject
+ (void)loadNewBlodWithSinceID:(id)ID success:(void (^)(NSArray *status))success failure:(void (^)(NSError *error))failure;
+ (void)loadMoreBlodWithMaxID:(id)ID success:(void (^)(NSArray *status))success failure:(void (^)(NSError *error))failure;
@end
