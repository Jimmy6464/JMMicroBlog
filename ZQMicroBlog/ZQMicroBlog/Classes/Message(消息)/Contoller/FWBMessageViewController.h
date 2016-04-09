//
//  FWBMessageViewController.h
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/2.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWBMessageDelegate.h"
@interface FWBMessageViewController : UITableViewController
@property(nonatomic,assign)id<FWBMessageDelegate>delegate;
@end
