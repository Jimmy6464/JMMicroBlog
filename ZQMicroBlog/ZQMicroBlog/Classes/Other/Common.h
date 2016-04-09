//
//  Common.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#define APPKey @"2318637190"
#define AppSecret @"c50e8df114cdf83c43cee71c1f304660"
#define Redirect_uri @"https://www.baidu.com"
#define KeyWindow [UIApplication sharedApplication].keyWindow

#define LeftMargin 10
#define TopMargin 10
#define StatusKey @"SpreadStatus"

#define CellFont [UIFont systemFontOfSize:20.0]
#define CurrentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]