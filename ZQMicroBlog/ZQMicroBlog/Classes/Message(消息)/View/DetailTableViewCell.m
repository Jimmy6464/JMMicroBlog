//
//  DetailTableViewCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/27.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "FWBMessage.h"
#import  "CellView.h"
#import "DetailCellView.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
#define theX 10
@interface DetailTableViewCell()
{
    UIImageView *_profile_image_url;//回复人头像
    UILabel *_userName;
    UILabel *_created_at;
    UILabel *_source;//设备
    UILabel *_text;
    UILabel *_replyText;

}
@end
@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self subAllView];
    }
    return self;
}
-(void)subAllView{
    _profile_image_url=[UIImageView new];
    _userName=[UILabel new];
    _created_at=[UILabel new];
    _source=[UILabel new];
    _text=[UILabel new];
    _text.numberOfLines=0;
    _replyText=[UILabel new];
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
    
    NSDictionary *_retweeted_status=messageBase.retweeted_status;
    if (_retweeted_status) {
    //用户头像
    NSString *path=[[_retweeted_status objectForKey:@"user"]objectForKey:@"profile_image_url"];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _profile_image_url.image=[UIImage imageWithData:data];
    _profile_image_url.frame=CGRectMake(theX, 5, 36, 36);
    
    //按钮
    _btn.frame=CGRectMake(CGRectGetMaxX(_profile_image_url.frame)+260, 5, 52, 27);
    _btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_btn setBackgroundImage:[UIImage imageNamed:@"compose_photo_preview_seleted"] forState:UIControlStateNormal];
    [_btn setTintColor:[UIColor orangeColor]];
    [_btn setTitle:@"+关注" forState:UIControlStateNormal];
    
    //用户名
    _userName.text=[[_retweeted_status objectForKey:@"user"]objectForKey:@"name"];
    _userName.font=[UIFont systemFontOfSize:15];
    CGFloat userLableX=CGRectGetMaxX(_profile_image_url.frame);
    CGSize   userLableW=[_userName sizeThatFits:CGSizeMake(CGFLOAT_MAX, 20) ];
    _userName.frame=CGRectMake(userLableX+10, 6, userLableW.width, userLableW.height);
    
    //内容
    _text.attributedText = [NSMutableAttributedString changeTextAttributed:messageBase.text withFontSize:15];
    _text.font=[UIFont systemFontOfSize:18];
    CGSize  textLableW=[self sizeWithString:_text.text font:_text.font];
    _text.frame=CGRectMake(_profile_image_url.frame.origin.x,CGRectGetMaxY(_profile_image_url.frame)+8, textLableW.width, textLableW.height);
    
    //时间
    _created_at.text=[_retweeted_status objectForKey:@"created_at"];
    _created_at.textColor=[UIColor lightGrayColor];
    _created_at.font=[UIFont systemFontOfSize:10];
    _created_at.tintColor=[UIColor lightGrayColor];
    _created_at.frame=CGRectMake(_userName.frame.origin.x,CGRectGetMaxY( _userName.frame)+5, 100, 10);
    //设备
    NSArray *stringArr=[[_retweeted_status objectForKey:@"source" ] componentsSeparatedByString:@">"];
    NSArray *stringArr2=[stringArr[1] componentsSeparatedByString:@"<"];
    _source.text=[NSString stringWithFormat:@"来自 %@",stringArr2[0]];
    _source.textColor=[UIColor lightGrayColor];
    _source.font=[UIFont systemFontOfSize:13];
    _source.tintColor=[UIColor lightGrayColor];
    _source.frame=CGRectMake(CGRectGetMaxX(_created_at.frame), _created_at.frame.origin.y, 100, 10);
    
    _rowHeight=CGRectGetMaxY(_text.frame)+8;
        

    //原图
    if ([_retweeted_status objectForKey:@"original_pic"]) {
    NSString *imagepath=[_retweeted_status objectForKey:@"original_pic"];
    NSURL *imageurl=[NSURL URLWithString:imagepath];
    NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
    NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    UIImage *theimage=[UIImage imageWithData:data2];
    float scaNum=_text.frame.size.width/theimage.size.width;
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(theX, CGRectGetMaxY(_text.frame), _text.frame.size.width, theimage.size.height*scaNum)];
    imageV.image=theimage;
    [self addSubview:imageV];
        _rowHeight=CGRectGetMaxY(imageV.frame);

    }

        
    }
    else{
        NSString *ttext=[messageBase.status objectForKey:@"text"];
        DetailCellView *cellView=[[DetailCellView alloc]initWithFrame:CGRectMake(0, 0, 375, [self sizeWithString:ttext font:[UIFont systemFontOfSize:15]].height+108)];
        cellView.messageBase=messageBase;
        [self addSubview:cellView];
        
        NSDictionary *statusDic=messageBase.status;
        if ([statusDic objectForKey:@"original_pic"]) {
            NSString *imagepath=[statusDic objectForKey:@"original_pic"];
            NSURL *imageurl=[NSURL URLWithString:imagepath];
            NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
            NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
            UIImage *theimage=[UIImage imageWithData:data2];
            float scaNum=cellView.frame.size.width/theimage.size.width;
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(theX,[self sizeWithString:ttext font:[UIFont systemFontOfSize:15]].height+56, [self sizeWithString:ttext font:[UIFont systemFontOfSize:15]].width, theimage.size.height*scaNum)];
            imageV.image=theimage;
            [self addSubview:imageV];
            _rowHeight=CGRectGetMaxY(imageV.frame);

        }

        
    }

}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(352, 0)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size;
}

@end
