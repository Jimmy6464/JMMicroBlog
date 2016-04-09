//
//  DetailViewController.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/27.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessageDelegate.h"
@interface DetailViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,FWBMessageDelegate>
@end
