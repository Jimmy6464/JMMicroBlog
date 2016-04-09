//
//  DetailProfileController.h
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileData.h"
#import "MicroBlogCell.h"
//#define CurrentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]
@interface DetailProfileController : UIViewController
@property(strong,nonatomic)ProfileData *profileData;
@end
