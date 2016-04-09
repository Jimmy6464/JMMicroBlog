//
//  ReplyTableViewCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "ReplyTableViewCell.h"
#import "FWBMessage.h"
#import "CellView.h"
//#import "MLEmojiLabel.h"
@interface ReplyTableViewCell(){
    UIImageView *_profile_image_url;//回复人头像
    UILabel *_userName;
    UILabel *_created_at;
    UILabel *_source;//设备
    UILabel *_text;
    UILabel *_replyText;
    
    UIView *view;
    UILabel  *label1;
    
}
@end
@implementation ReplyTableViewCell

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
//初始化控件
-(void)subAllView{
    [self addSubview:_btn];
}
-(void)setMessageBase:(FWBMessage *)messageBase
{
    NSString *text = messageBase.text;
    CGFloat f=[self viewsizeWithString:text];
    CellView *cellView=[[CellView alloc]initWithFrame:CGRectMake(0, 0, 375, [self viewsizeWithString:text]+108)];
    
    _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame=CGRectMake(10, f+50+7, 355, 75);
    _btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchDragExit];
    [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchUpInside];
    
        NSString *path=[messageBase.status objectForKey:@"thumbnail_pic"];
        NSURL *url=[NSURL URLWithString:path];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
        imageV.image=[UIImage imageWithData:data];
        NSDictionary *dic=[messageBase.status objectForKey:@"user"];
        
        UILabel *label2=[[UILabel alloc]init];
        UILabel *label3=[[UILabel alloc]init];
        label2.text=[NSString stringWithFormat:@"@%@",[dic objectForKey:@"name"]];
        label2.font=[UIFont systemFontOfSize:14];
        label2.frame=CGRectMake(CGRectGetMaxX(imageV.frame)+5,4, 200, 30);
        
        label3.text=[messageBase.status objectForKey:@"text"];
        label3.textColor=[UIColor lightGrayColor];
        label3.numberOfLines=2;
        CGSize labelsize=[label3 sizeThatFits:CGSizeMake(280, 26)];
        label3.font=[UIFont systemFontOfSize:12];
        label3.frame=CGRectMake(CGRectGetMaxX(imageV.frame)+5, CGRectGetMaxY(label2.frame)-8, 280,labelsize.height);
        
        [_btn addSubview:label2];
        [_btn addSubview:label3];
        [_btn addSubview:imageV];
        [view setBackgroundColor:[UIColor whiteColor]];
    
    cellView.messageBase=messageBase;
    [cellView addSubview:_btn];
    [self addSubview:cellView];
    
}
-(void)btnActionT:(UIButton *)btn{
    _btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    
}
-(void)btnAction:(UIButton *)btn{
    _btn.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
}
//自适应方法
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
- (CGFloat)viewsizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size.height;
}
@end
