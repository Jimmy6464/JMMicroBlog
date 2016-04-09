//
//  NaviViewController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "NaviViewController.h"
#import "UIBarButtonItem+SetUpBarButtonItem.h"
#import "MyTabBar.h"
@interface NaviViewController ()<UINavigationControllerDelegate>

@end

@implementation NaviViewController
+ (void)initialize
{
    if (self == [NaviViewController class]) {
        [self setUpNavBarButton];
        [self setUpNavBarTitle];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置所有导航条barButton
+ (void)setUpNavBarButton
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateHighlighted];
}
#pragma mark - 设置导航条的标题
+ (void)setUpNavBarTitle
{
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:[NaviViewController class], nil];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:20.0];
    [nav setTitleTextAttributes:dictM];
}
#pragma mark - 设置子controller的导航条
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) {//不是根控制器

        
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *popToSup = [UIBarButtonItem barButtonWithImage:@"navigationbar_back" highligthedImage:@"navigationbar_back_highlighted" selector:@selector(popToSuperView) target:self];
        viewController.navigationItem.leftBarButtonItem = popToSup;
        
        UIBarButtonItem *popToRoot = [UIBarButtonItem barButtonWithImage:@"navigationbar_more" highligthedImage:@"navigationbar_more_highlighted" selector:@selector(popToRootView) target:self];
        viewController.navigationItem.rightBarButtonItem = popToRoot;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - 返回父controller
- (void)popToSuperView
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - 返回根controller
- (void)popToRootView
{
    [self popToRootViewControllerAnimated:YES];
}
#pragma mark - 删除系统自身的TabBar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[MyTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}
@end
