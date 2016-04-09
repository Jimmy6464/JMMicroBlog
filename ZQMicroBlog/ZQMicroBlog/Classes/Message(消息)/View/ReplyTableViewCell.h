//
//  ReplyTableViewCell.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWBMessage;
@interface ReplyTableViewCell : UITableViewCell
@property(strong,nonatomic)FWBMessage *messageBase;
@property(strong,nonatomic)UIButton *btn;
@end
