//
//  FWBTalkController.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessage.h"
#import "FWBMessageDelegate.h"
@interface FWBTalkController : UIViewController
<FWBMessageDelegate,UITableViewDataSource,UITableViewDelegate>
@property(assign,nonatomic)id<FWBMessageDelegate>delegate;
@end
