//
//  TextTableViewCell.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/30.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessage.h"
@interface TextTableViewCell : UITableViewCell
@property(strong,nonatomic)FWBMessage *messageBase;
@property(assign,nonatomic)CGFloat rowHeight;
@property(strong,nonatomic)UIButton *btn;

@end
