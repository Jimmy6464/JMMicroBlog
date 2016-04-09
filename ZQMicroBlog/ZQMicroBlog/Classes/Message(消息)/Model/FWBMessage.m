//
//  FWBMessage.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "FWBMessage.h"

@implementation FWBMessage
-(id)initWithDictionary:(NSDictionary *)dictionary{
        if (self=[super init]) {
            _created_at=[dictionary objectForKey:@"created_at"];
            _text=[dictionary objectForKey:@"text"];
            _Id=[[dictionary objectForKey:@"id"]integerValue];
            _source=[dictionary objectForKey:@"source"];
            _mid=[dictionary objectForKey:@"mid"];
            _user=[dictionary objectForKey:@"user"];
            _status=[dictionary objectForKey:@"status"];
            _attitudes_count=[[dictionary objectForKey:@"attitudes_count"]integerValue];
            for (NSString *key in [dictionary allKeys]) {
                if ([key isEqualToString:@"reply_comment"]) {
                    _reply_comment=[dictionary objectForKey:@"reply_comment"];
                }else{
                    _reply_comment=nil;
                }
                if ([key isEqualToString:@"retweeted_status"]) {
                    _retweeted_status=[dictionary objectForKey:@"retweeted_status"];
                }
            }

            NSString *path=[_user objectForKey:@"profile_image_url"];
            NSURL *url=[NSURL URLWithString:path];
            NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
            NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            _profileImageData=data;
        }
        return self;
}

+(id)StutasWithDictionary:(NSDictionary *)dictionary{
    return [[FWBMessage alloc]initWithDictionary:dictionary];
}
@end
