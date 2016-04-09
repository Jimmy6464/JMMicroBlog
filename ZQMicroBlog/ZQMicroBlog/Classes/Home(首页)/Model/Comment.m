//
//  Comment.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "Comment.h"

@implementation Comment
- (NSString *)created_at
{
    if ([_created_at intValue]) {
        return _created_at;
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    //真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    // 获取微博创建时间
    NSDate *createdTime = [fmt dateFromString:_created_at];
    fmt.dateFormat = @"M月d日 HH点mm分";
    
    // 时间格式化成字符串
    NSString *createdTimeStr = [fmt stringFromDate:createdTime];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:createdTime];
    NSTimeInterval second = time;       // 时间单位换算成 秒
    NSTimeInterval minute = time / 60;  // 时间单位换算成 分
    NSTimeInterval hour = minute / 60;  // 时间单位换算成 时
    NSTimeInterval day = hour / 24;     // 时间单位换算成 天
    NSTimeInterval year = day / 365;    // 时间单位换算成 年
    
    if (second < 60) {                  // 1分钟之内显示 "刚刚"
        return @"刚刚";
    } else if (minute < 60) {           // 1小时之内显示 "x分钟前"
        return [NSString stringWithFormat:@"%.f分钟前", minute];
    } else if (hour < 24) {             // 1天之内显示 "x小时前"
        return [NSString stringWithFormat:@"%.f小时前", hour];
    } else if (day < 7) {               // 1周之内显示 "x天前"
        return [NSString stringWithFormat:@"%.f天前", day];
    } else if (year >= 1) {             // 1年以前显示 "xxxx年x月x日"
        fmt.dateFormat = @"yyyy年M月d日";
        return [fmt stringFromDate:createdTime];
    } else {                            // 1年以内显示 "x月x日 x点x分"
        return createdTimeStr;
    }
}
- (void)setSource:(NSString *)source
{
    if ([source isEqualToString:@""]) return;
    
    NSString *first = [source substringToIndex:1];
    if ([first isEqualToString:@"来"]) {
        _source = source;
        return;
    }
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + 1];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    
    _source = [NSString stringWithFormat:@"来自%@",source];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"text:%@",_text];
}
@end
