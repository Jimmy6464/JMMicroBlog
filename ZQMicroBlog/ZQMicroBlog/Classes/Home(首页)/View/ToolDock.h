//
//  ToolDock.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToolDockDelegate
- (void)btnPressedAtIndex:(NSInteger)index;
@end
@class Statues;
@interface ToolDock : UIImageView
@property (nonatomic, strong) Statues *status;
@property (nonatomic, weak) id<ToolDockDelegate> delegate;
@end
