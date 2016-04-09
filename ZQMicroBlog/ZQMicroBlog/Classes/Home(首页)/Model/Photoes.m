//
//  Photoes.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "Photoes.h"

@implementation Photoes
- (void)setThumbnail_pic:(NSURL *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",_thumbnail_pic];

    [string replaceCharactersInRange:[string rangeOfString:@"thumbnail"] withString:@"large"];
    _large_pic = [NSURL URLWithString:string];
    
    [string replaceCharactersInRange:[string rangeOfString:@"large"] withString:@"bmiddle"];
    _bmiddle_pic = [NSURL URLWithString:string];
}
@end
