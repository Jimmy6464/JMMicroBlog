//
//  MyTabBarButton.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBadgeView.h"
@interface MyTabBarButton : UIButton
/**
 *  用作接收原系统item的信息
 */
@property (nonatomic, strong)UITabBarItem *item;
/**
 *  小圆点view，用作显示新数据数
 */
@property (nonatomic, strong)MyBadgeView *badgeView;
@end
