//
//  DetailCellView.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/28.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessageCell.h"

@class FWBMessage;
@interface DetailCellView : UIView
@property(strong,nonatomic)  UIImageView *profile_image_url;//回复人头像
@property(strong,nonatomic)  UILabel *userName;
@property(strong,nonatomic) UILabel *created_at;
@property(strong,nonatomic) UILabel *source;//设备
@property (nonatomic, strong) UILabel *text;
@property(strong,nonatomic) UILabel *replyText;

@property(strong,nonatomic) UIView *view;
@property(strong,nonatomic) UILabel *label1;

@property(strong,nonatomic)FWBMessage *messageBase;
@property(assign,nonatomic)CGFloat rowHeight;
@property(strong,nonatomic)UIButton *btn;
@end
