//
//  MainController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MainController.h"

#import "HomeController.h"
#import "FWBMessageViewController.h"
#import "ProfileController.h"
#import "DiscoverController.h"
#import "NaviViewController.h"

#import "MyTabBar.h"

#import "MicrologTypeBtnView.h"
#import "BaseMicorologEditViewController.h"
#import "LocationViewController.h"
#import "longMicrologViewController.h"
#import "PhotoViewController.h"
#import "RemarkMainViewController.h"
#import "TypeBtnView.h"

#import "UserTool.h"
#import "UserUnread.h"
#import "MJRefresh.h"
@interface MainController ()<MyTabBarDelegate,TypeBtnViewDelegate>
@property (nonatomic, strong) HomeController *home;
@property (nonatomic, strong) FWBMessageViewController *message;
@property (nonatomic, strong) DiscoverController *discover;
@property (nonatomic, strong) ProfileController *profile;

@property (nonatomic, strong) MyTabBar *myTabBar;
@property (nonatomic, strong) MicrologTypeBtnView *MTBV;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置自定义tabBar
    [self setUpSelfTabBar];
    //2.添加所有子控制器
    [self setUpAllChildController];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 1.设置自定义tabBar
- (void)setUpSelfTabBar
{
    MyTabBar *tabBar = [MyTabBar new];
    tabBar.frame = self.tabBar.bounds;
    [tabBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]]];
    tabBar.tbDelegate = self;
    [self.tabBar addSubview:tabBar];
    _myTabBar = tabBar;
}
#pragma mark - 2.添加所有子控制器
- (void)setUpAllChildController
{
    /**
     home(首页)
     */
    HomeController *home = [[HomeController alloc]init];
    home.tabBarItem.badgeValue = @"200";
    [self setUpSingleChildController:home withTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_highlighted"];
    _home = home;
    /**
     message(消息)
     */
    FWBMessageViewController *message = [[FWBMessageViewController alloc]init];
    [self setUpSingleChildController:message withTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_highlighted"];
    _message = message;
    
    /**
     discover(发现)
     */
    DiscoverController *discover = [[DiscoverController alloc]init];
    [self setUpSingleChildController:discover withTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_highlighted"];
    _discover = discover;
    /**
     profile(资料)
     */
    ProfileController *profile = [[ProfileController alloc]init];
    [self setUpSingleChildController:profile withTitle:@"资料" image:@"tabbar_profile" selectedImage:@"tabbar_profile_highlighted"];
    _profile = profile;

}
#pragma mark - 3.添加单个子控制器
- (void)setUpSingleChildController:(UIViewController *) viewCotroller withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *) selectedImage
{
    viewCotroller.title = title;
    viewCotroller.tabBarItem.image = [UIImage imageNamed:image];
    viewCotroller.tabBarItem.selectedImage = [UIImage imageWithOriginalName:selectedImage];
    NaviViewController *navi = [[NaviViewController alloc]initWithRootViewController:viewCotroller];
    [_myTabBar addItemToTabBarButtos:viewCotroller.tabBarItem];
    [self addChildViewController:navi];
    
}
#pragma mark - 获得未读数
//获得未读数
- (void)setupUnreadCount
{
    [UserTool unreadCountDidsuccess:^(UserUnread *unRead) {
        // 设置首页提醒
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.status];
        
        // 设置消息提醒
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.messageCount];
        
        // 设置我提醒
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.follower];
        
//        // 设置application提醒数字
//        [UIApplication sharedApplication].applicationIconBadgeNumber = unRead.totalCount;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - MyTabBarDelegate
- (void)tabBar:(MyTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    if (selectedIndex == 0) {
        [_home.tableView headerBeginRefreshing];
    }
    
}
//实现tabber协议的加号方法,初始化MicrologTypeBtnView
-(void)plusButtonAction
{
    if (_MTBV == nil) {
        _MTBV= [[MicrologTypeBtnView alloc]init];
        NSArray *typeBtnViewArr = [self.MTBV.pageOne subviews];
        for (UIView *tbv in typeBtnViewArr) {
            if ([tbv isKindOfClass:[TypeBtnView class]]) {
                TypeBtnView *typeB = (TypeBtnView *)tbv;
                typeB.tbDelegate = self;
            }
        }
        [self.view addSubview:_MTBV];
        [_MTBV closeStatic];
        [_MTBV showSelf];
    }
    else
    {
        
        [_MTBV showSelf];
        
    }
    
    
}

#pragma mark - 下面是实现typeBtnViewDelegate协议的代码

-(void)removeMTBV
{
    _MTBV.hidden = YES;
    [_MTBV closeStatic];
    
}

//跳转到编辑基础微博页面
-(void)pushToBaseMicroblogEditController
{
    
    BaseMicorologEditViewController *BMEVC = [[BaseMicorologEditViewController alloc]initWithTitleName:@"发微博"];
    NaviViewController *na = [[NaviViewController alloc]initWithRootViewController:BMEVC];
    [self presentViewController:na animated:YES completion:nil];
    [self performSelector:@selector(removeMTBV) withObject:nil afterDelay:0.5];
    
}

//跳转到加载本地图片页面
-(void)pushToGetPhotoController
{
    PhotoViewController *PVC = [[PhotoViewController alloc]init];
    NaviViewController *na = [[NaviViewController alloc]initWithRootViewController:PVC];
    [self presentViewController:na animated:YES completion:nil];
    
    [self performSelector:@selector(removeMTBV) withObject:nil afterDelay:0.5];
    
}
//跳转到编辑长微博页面
-(void)pushToEditLongMicrologController
{
    longMicrologViewController *LMVC = [[longMicrologViewController alloc]init];
    NaviViewController *na = [[NaviViewController alloc]initWithRootViewController:LMVC];
    [self presentViewController:na animated:YES completion:nil];
    
    [self performSelector:@selector(removeMTBV) withObject:nil afterDelay:0.2];
    
}
//跳转到地点签到页面
-(void)pushToLocationController
{
    LocationViewController *LVC = [[LocationViewController alloc]init];
    NaviViewController *na =[[NaviViewController alloc]initWithRootViewController:LVC];
    [self presentViewController:na animated:YES completion:nil];
    
    [self performSelector:@selector(removeMTBV) withObject:nil afterDelay:0.2];
    
}
//跳转到点评页面
-(void)pushToRemarkMicrologController
{
    RemarkMainViewController *RMVC = [[RemarkMainViewController alloc]init];
    NaviViewController *na = [[NaviViewController alloc]initWithRootViewController:RMVC];
    [self presentViewController:na animated:YES completion:nil];
    
    [self performSelector:@selector(removeMTBV) withObject:nil afterDelay:0.2];
    
}

-(void)gotoNextPage
{
    [_MTBV initPageTwo];
}


@end
