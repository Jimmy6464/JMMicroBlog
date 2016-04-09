//
//  MicrologTypeBtnView.h
//  dasdas
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MicrologTypeBtnView : UIView<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *typeBtnScrollerView;
@property (nonatomic ,strong)UIView *pageOne;
@property (nonatomic ,strong)UIView *pageTwo;
-(void)showSelf;
-(void)closeStatic;
-(void)initPageTwo;
@end
