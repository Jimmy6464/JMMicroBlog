//
//  TalkTableViewCell.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWBMessage;
#import "FWBMessageDelegate.h"
@interface TalkTableViewCell : UITableViewCell
@property(strong,nonatomic)FWBMessage *messageBase;
@property(strong,nonatomic)   UIButton *btn;
@property(assign,nonatomic)id<FWBMessageDelegate>delegate;
@end
