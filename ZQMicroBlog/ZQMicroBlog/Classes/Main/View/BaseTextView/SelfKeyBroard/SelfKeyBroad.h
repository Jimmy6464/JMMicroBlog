//
//  SelfKeyBroad.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "EmoticonView.h"
#import "TextAndImageTool.h"
#import <UIKit/UIKit.h>
@protocol keyBroadDelegate<NSObject>
-(void)presentToPhotoViewController;
-(void)presentToTrendViewController;
-(void)presentToMentionController;
-(void)emoBtnAction:(NSString *)str;
@end
@interface SelfKeyBroad : UIView<emoticonBtnDelegate>
@property (nonatomic ,strong) id owner;
@property (nonatomic ,strong) id<keyBroadDelegate> kbDelegate;
@property (nonatomic ,assign) CGFloat keybarodH;//键盘的高度
-(void)updateSelfHighWithHigh:(CGFloat)h;
@end
