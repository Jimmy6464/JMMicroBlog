//
//  UserUnread.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "UserUnread.h"

@implementation UserUnread
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return self.messageCount + _follower  + _status;
}
@end
