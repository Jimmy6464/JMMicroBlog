//
//  StatusParams.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/9.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusParams : NSObject
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) id max_id;
@property (nonatomic, strong) id since_id;
@property (nonatomic, strong) id count;
@end
