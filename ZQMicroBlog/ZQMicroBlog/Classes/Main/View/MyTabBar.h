//
//  MyTabBar.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;
@protocol MyTabBarDelegate<NSObject>
- (void)tabBar:(MyTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex;
- (void)plusButtonAction;
@end
@interface MyTabBar : UITabBar
@property (nonatomic, weak) id<MyTabBarDelegate> tbDelegate;

- (void)addItemToTabBarButtos:(UITabBarItem *)item;

@end
