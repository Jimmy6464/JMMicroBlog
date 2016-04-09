//
//  DetailTableViewCell.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/27.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWBMessage;
@interface DetailTableViewCell : UITableViewCell
@property(strong,nonatomic)FWBMessage *messageBase;
@property(strong,nonatomic)UIButton *btn;
@property(assign,nonatomic)CGFloat rowHeight;
@end
