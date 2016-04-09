//
//  EmoticonView.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "SelfPageControll.h"
#import <UIKit/UIKit.h>
@protocol emoticonBtnDelegate<NSObject>
-(void)imageBtnAction:(UIButton *)btn;
-(void)emoticonBtnAction:(UIButton *)btn;
-(void)deleteBtnAciton;
@end
@interface EmoticonView : UIView<UIScrollViewDelegate,selfPageDelegate>
@property (nonatomic ,strong) id<emoticonBtnDelegate> ebDelegate;
@end
