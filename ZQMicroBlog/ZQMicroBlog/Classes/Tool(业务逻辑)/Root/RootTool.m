//
//  RootTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "RootTool.h"
#import "MainController.h"
#import "NewFeatureController.h"
#define VersionKey @"verson"
#define UserDefaults [NSUserDefaults standardUserDefaults]
@implementation RootTool
+ (void)chooseRootController:(UIWindow *)window
{
    //1.获取旧版本号
    NSString *oldVersion = [UserDefaults objectForKey:VersionKey];
    //2.获取当前版本号
    NSString *currentVersion  = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([oldVersion isEqualToString:currentVersion]) {
        //主界面
        MainController *main = [MainController new];
        window.rootViewController = main;
    }else{
        //新特性界面
        NewFeatureController *newF = [NewFeatureController new];
        window.rootViewController = newF;
        [UserDefaults setObject:currentVersion forKey:VersionKey];
    }
}

@end
