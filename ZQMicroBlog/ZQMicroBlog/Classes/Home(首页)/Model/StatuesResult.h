//
//  StatuesResult.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statues.h"
#import "MJExtension.h"
@interface StatuesResult : NSObject
@property (nonatomic, assign) long long total_number;

@property (nonatomic, strong) NSArray *statuses;
@end
