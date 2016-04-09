//
//  SelfPageItemButton.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selfPageItemDelegate<NSObject>
@optional
-(void)addAciton:(UIButton *)btn;
@end
@interface SelfPageItemButton : UIButton
@property (nonatomic ,strong) id<selfPageItemDelegate> spiDelegate;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title andNum:(NSInteger)num;
-(void)btnAction:(UIButton *)sender;
-(void)buttonUp;
@end
