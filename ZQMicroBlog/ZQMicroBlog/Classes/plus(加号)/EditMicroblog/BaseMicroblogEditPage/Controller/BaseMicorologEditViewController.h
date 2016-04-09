//
//  BaseMicorologEditViewController.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "SelfKeyBroad.h"
#import <UIKit/UIKit.h>

@interface BaseMicorologEditViewController : UIViewController<UITextViewDelegate,keyBroadDelegate>
-(instancetype)initWithTitleName:(NSString *)titleName;
@property (nonatomic ,assign) NSInteger microlongId;
@property (nonatomic ,assign) NSInteger CId;
@end
