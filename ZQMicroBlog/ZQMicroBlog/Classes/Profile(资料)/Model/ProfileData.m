//
//  ProfileData.m
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ProfileData.h"

@implementation ProfileData
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        _ID=[[dictionary objectForKey:@"id"]integerValue];
        _screen_name=[dictionary objectForKey:@"screen_name"];
        _name=[dictionary objectForKey:@"name"];
        _location=[dictionary objectForKey:@"location"];
        _Description=[dictionary objectForKey:@"description"];
        _followers_count=[[dictionary objectForKey:@"followers_count"]integerValue];//粉丝数
        _friends_count=[[dictionary objectForKey:@"friends_count"]integerValue];//关注数
        _statuses_count=[[dictionary objectForKey:@"statuses_count"]integerValue];//评论数
        _gender=[dictionary objectForKey:@"gender"];
        
        NSString *path=[dictionary objectForKey:@"avatar_large"];
        NSURL *url=[NSURL URLWithString:path];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        _avatar_largeData=data;
    }
    return self;
}

+(id)StutasWithDictionary:(NSDictionary *)dictionary{
    return [[ProfileData alloc]initWithDictionary:dictionary];
}
@end
