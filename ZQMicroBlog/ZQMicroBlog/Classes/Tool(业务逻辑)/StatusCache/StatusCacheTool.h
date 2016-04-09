//
//  StatusCacheTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/9.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StatusParams;
@interface StatusCacheTool : NSObject
+ (void)saveWithStatus:(NSArray *)dictArr;
+ (NSArray *)statusesWithParam:(StatusParams *)params;
@end
