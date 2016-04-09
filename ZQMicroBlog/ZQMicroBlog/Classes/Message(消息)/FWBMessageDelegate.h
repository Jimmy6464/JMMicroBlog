//
//  FWBMessageDelegate.h
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWBMessage.h"
@protocol FWBMessageDelegate <NSObject>
@optional
-(void)getTitle:(NSInteger)indexR;
-(void)getAccessToken:(NSString *)token;
-(void)pushMessage:(FWBMessage *)messageBase;
-(void)getMessage:(FWBMessage *)messageBase;

@end
