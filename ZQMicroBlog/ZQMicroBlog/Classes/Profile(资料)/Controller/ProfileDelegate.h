//
//  ProfileDelegate.h
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileData.h"
@protocol ProfileDelegate <NSObject>
@optional
-(void)getProfileData:(ProfileData *)data;
@end
