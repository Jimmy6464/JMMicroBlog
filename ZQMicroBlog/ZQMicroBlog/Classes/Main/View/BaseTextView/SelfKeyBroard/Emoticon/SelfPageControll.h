//
//  SelfPageControll.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "SelfPageItemButton.h"
#import <UIKit/UIKit.h>
@protocol selfPageDelegate<NSObject>
-(void)addAction:(UIButton *)btn;
@end
@interface SelfPageControll : UIView<selfPageItemDelegate>
@property (nonatomic,assign) NSInteger numOfPages;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) UIScrollView *defaultSender;
@property (nonatomic,strong) id<selfPageDelegate> pageDelegate;
@property (nonatomic,strong) NSArray *titleItems;
- (instancetype)initWithFrame:(CGRect)frame andTitleItems:(NSArray *)titleItems;
@end
