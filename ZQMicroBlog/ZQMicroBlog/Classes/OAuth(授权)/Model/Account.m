//
//  Account.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "Account.h"
#define UIDKey @"uid"
#define Access_TokenKey @"access_token"
#define NameKey @"name"
#define Expires_TimeKey @"expires_time"
#define Expires_InKey @"expires_in"
@implementation Account
+ (instancetype)accountWithDictionary:(NSDictionary *)dict
{
    Account *account = [[Account alloc]init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _access_token = [aDecoder decodeObjectForKey:Access_TokenKey];
        _name = [aDecoder decodeObjectForKey:NameKey];
        _uid = [aDecoder decodeObjectForKey:UIDKey];
        _expires_in = [aDecoder decodeObjectForKey:Expires_InKey];
        _expires_time = [aDecoder decodeObjectForKey:Expires_TimeKey];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:NameKey];
    [aCoder encodeObject:_uid forKey:UIDKey];
    [aCoder encodeObject:_expires_time forKey:Expires_TimeKey];
    [aCoder encodeObject:_expires_in forKey:Expires_InKey];
    [aCoder encodeObject:_access_token forKey:Access_TokenKey];
}
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    NSDate *date = [NSDate date];
    _expires_time = [date dateByAddingTimeInterval:[expires_in longLongValue]];
}
@end
