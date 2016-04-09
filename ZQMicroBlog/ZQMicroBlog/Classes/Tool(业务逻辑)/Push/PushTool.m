//
//  PushTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "PushTool.h"
#import "NaviViewController.h"
@implementation PushTool
+ (void)pushController:(UIViewController *)controller byView:(UIView *)view withObject:(NSDictionary *)userInfo
{
    UIViewController *result = nil;
    id nextResponer = [view nextResponder];
    while (true) {
        if ([nextResponer isKindOfClass:[UIViewController class]]) {
            result = nextResponer;
            break;
        }else {
            nextResponer = [nextResponer nextResponder];
        }
    }
    if (userInfo.allKeys.count > 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfo.allKeys[1] object:nil userInfo:userInfo];
        [result.navigationController pushViewController:controller animated:YES];
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:userInfo.allKeys[0] object:nil userInfo:userInfo];
    [result.navigationController pushViewController:controller animated:YES];
}
+ (void)presentController:(UIViewController *)controller byView:(UIView *)view withObject:(NSDictionary *)userInfo
{
    UIViewController *result = nil;
    id nextResponer = [view nextResponder];
    while (true) {
        if ([nextResponer isKindOfClass:[UIViewController class]]) {
            result = nextResponer;
            break;
        }else {
            nextResponer = [nextResponer nextResponder];
        }
    }
    if (userInfo.allKeys.count > 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfo.allKeys[1] object:nil userInfo:userInfo];
        [result.navigationController pushViewController:controller animated:YES];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfo.allKeys[0] object:nil userInfo:userInfo];
    }
    NaviViewController *na = [[NaviViewController alloc]initWithRootViewController:controller];
    [result presentViewController:na animated:YES completion:nil];
}
@end
