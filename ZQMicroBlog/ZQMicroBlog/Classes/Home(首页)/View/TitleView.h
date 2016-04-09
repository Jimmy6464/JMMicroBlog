//
//  TitleView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;
@protocol TitleView
- (void)removeTitleView:(TitleView *)title;
@end
@interface TitleView : UIView
@property (nonatomic, strong)UIImageView *backgroundView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIButton *editGroudButton;

@property (nonatomic, weak)id<TitleView> delegate;
- (void)showTitleViewInRect:(CGRect)frame;

@end
