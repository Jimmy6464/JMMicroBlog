//
//  AppDelegate.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "OAuthController.h"
#import "AccountTool.h"
#import "RootTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    if ([AccountTool account]) {
        [RootTool chooseRootController:self.window];
    }else {
        OAuthController *oauth = [OAuthController new];
        self.window.rootViewController = oauth;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
