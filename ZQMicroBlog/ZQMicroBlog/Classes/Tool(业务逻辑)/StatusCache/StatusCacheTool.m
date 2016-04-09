//
//  StatusCacheTool.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/9.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "StatusCacheTool.h"
#import "FMDB.h"
#import "StatusParams.h"
#import "Statues.h"
#import "AccountTool.h"
#import "MJExtension.h"
#define StatusFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"status.sqlite"]
static FMDatabase *_db;
@implementation StatusCacheTool
+ (void)initialize
{
    _db = [FMDatabase databaseWithPath:StatusFile];
    if ([_db open]) {
        BOOL isSuccessed = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text not null,dict blob not null,access_token text not null);"];
        if (isSuccessed) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }else {
        NSLog(@"打开失败");
    }
}
+ (void)saveWithStatus:(NSArray *)dictArr
{
    NSString *accessToken = [AccountTool account].access_token;
    for (NSDictionary *dict in dictArr) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        BOOL success =[_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?)",dict[@"idstr"],accessToken,data];
        if (success) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
        
        
    }

}
+ (NSArray *)statusesWithParam:(StatusParams *)params
{
    FMResultSet *set;
    if (params.max_id) {
        set = [_db executeQuery:@"select * from t_status where access_token = ? and idstr <= ?  order by idstr desc limit 20",params.access_token,params.max_id];
    }else if (params.since_id) {
        set = [_db executeQuery:@"select * from t_status where access_token = ? and idstr > ?  order by idstr desc limit 20",params.access_token,params.since_id];
    }else {
        set = [_db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 20",params.access_token];
    }
    NSMutableArray *mArr;
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        Statues *status = [Statues objectWithKeyValues:dict];
        [mArr addObject:status];
    }
    return mArr;
}
@end
