//
//  MainController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MainController.h"

#import "HomeController.h"
#import "MessageController.h"
#import "ProfileController.h"
#import "DiscoverController.h"
@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加所有子控制器
    [self setUpAllChildController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpAllChildController
{
    HomeController *home = [[HomeController alloc]init];
    home.title = @"首页";
//    home.tabBarItem.image = [UIImage imageNamed:]

}

@end
