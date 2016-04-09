//
//  PushTool.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushTool : NSObject
+ (void)pushController:(UIViewController *) controller byView:(UIView *)view withObject:(NSDictionary *) userInfo;
+ (void)presentController:(UIViewController *) controller byView:(UIView *)view withObject:(NSDictionary *) userInfo;
@end
