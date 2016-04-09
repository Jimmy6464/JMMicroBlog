//
//  ToMeViewController.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessageDelegate.h"
@interface ToMeViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
@property(assign,nonatomic)id<FWBMessageDelegate>delegate;
@end
