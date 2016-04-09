//
//  URLTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLTool : NSObject
+ (void)getLongURlwithShortURL:(NSString *)shortURl success:(void(^)(NSString *longURL)) success failure:(void(^)(NSError *error)) failure;
@end
