//
//  BlogCellDelgate.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BlogCellDelgate <NSObject>
//文本点击事件
- (void)contentClicked:(NSURL *)url;
@end
