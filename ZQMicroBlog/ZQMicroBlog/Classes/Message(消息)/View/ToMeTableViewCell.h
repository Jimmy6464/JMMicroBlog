//
//  ToMeTableViewCell.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessage.h"
#import "FWBMessageDelegate.h"
@interface ToMeTableViewCell : UITableViewCell
@property(strong,nonatomic)FWBMessage *messageBase;
@property(strong,nonatomic)UIButton *btn;

@property(strong,nonatomic)UIButton *transmit;//转发
@property(strong,nonatomic)UIButton *discuss;//评论
@property(strong,nonatomic)UIButton *spot;//点赞

@property(assign,nonatomic)id<FWBMessageDelegate>delegate;
@end
