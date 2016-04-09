//
//  ProfileController.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDelegate.h"
@interface ProfileController : UIViewController
@property(nonatomic,assign) id<ProfileDelegate> delegate;
@end
