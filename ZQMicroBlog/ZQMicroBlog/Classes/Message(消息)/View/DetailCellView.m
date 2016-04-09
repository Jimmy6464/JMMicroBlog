//
//  DetailCellView.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/28.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DetailCellView.h"
#import "FWBMessage.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
@implementation DetailCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self subAllView];
    }
    return self;
}
//初始化控件
-(void)subAllView{
    _profile_image_url=[UIImageView new];
    _userName=[UILabel new];
    _created_at=[UILabel new];
    _source=[UILabel new];
    _text=[UILabel new];
    _text.numberOfLines=0;
    _replyText=[UILabel new];
    _label1=[UILabel new];
    _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self addSubview:_profile_image_url];
    [self addSubview:_userName];
    [self addSubview:_created_at];
    [self addSubview:_source];
    [self addSubview:_text];
    [self addSubview:_replyText];
    [self addSubview:_btn];
    
}
-(void)setMessageBase:(FWBMessage *)messageBase
{
    
    NSDictionary *statusDic=messageBase.status;
    //用户头像
    _profile_image_url.image=[UIImage imageWithData:messageBase.profileImageData];
    _profile_image_url.frame=CGRectMake(10, 5, 36, 36);
    
    //回复按钮
    _btn.frame=CGRectMake(CGRectGetMaxX(_profile_image_url.frame)+260, 5, 52, 27);
    _btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_btn setBackgroundImage:[UIImage imageNamed:@"compose_photo_preview_seleted"] forState:UIControlStateNormal];
    [_btn setTintColor:[UIColor lightGrayColor]];
    [_btn setTitle:@"回复" forState:UIControlStateNormal];
    
    //用户名
    _userName.text=[[statusDic objectForKey:@"user"]objectForKey:@"name"];
    _userName.font=[UIFont systemFontOfSize:15];
    CGFloat userLableX=CGRectGetMaxX(_profile_image_url.frame);
    CGSize   userLableW=[_userName sizeThatFits:CGSizeMake(CGFLOAT_MAX, 20) ];
    _userName.frame=CGRectMake(userLableX+10, 6, userLableW.width, userLableW.height);
    
    //内容

    _text.attributedText = [NSMutableAttributedString changeTextAttributed:messageBase.text withFontSize:15];
    _text.font=[UIFont systemFontOfSize:15];
    CGSize  textLableW=[self sizeWithString:_text.text font:_text.font];
    _text.frame=CGRectMake(_profile_image_url.frame.origin.x,CGRectGetMaxY(_profile_image_url.frame)+8, textLableW.width, textLableW.height);
    
    //时间
    _created_at.text=[statusDic objectForKey:@"created_at"];
    _created_at.textColor=[UIColor lightGrayColor];
    _created_at.font=[UIFont systemFontOfSize:10];
    _created_at.tintColor=[UIColor lightGrayColor];
    _created_at.frame=CGRectMake(_userName.frame.origin.x,CGRectGetMaxY( _userName.frame)+5, 100, 10);
    //设备
    NSArray *stringArr=[[statusDic objectForKey:@"source"] componentsSeparatedByString:@">"];
    NSArray *stringArr2=[stringArr[1] componentsSeparatedByString:@"<"];
    _source.text=[NSString stringWithFormat:@"来自 %@",stringArr2[0]];
    _source.textColor=[UIColor lightGrayColor];
    _source.font=[UIFont systemFontOfSize:13];
    _source.tintColor=[UIColor lightGrayColor];
    _source.frame=CGRectMake(CGRectGetMaxX(_created_at.frame), _created_at.frame.origin.y, 100, 10);
    
}
//自适应方法

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size;
}

@end
