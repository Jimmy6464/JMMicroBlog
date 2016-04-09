//
//  TalkTableViewCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "TalkTableViewCell.h"
#import "FWBMessage.h"
#import "FWBTalkController.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
//#import "MLEmojiLabel.h"
@interface TalkTableViewCell(){
    UIView *view;
    UILabel  *label1;
    
}
@end
@implementation TalkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMessageBase:(FWBMessage *)messageBase{
    _messageBase=messageBase;
    label1=[UILabel new];
    NSDictionary *userDic=[messageBase.reply_comment objectForKey:@"user"];
    NSString *user=[NSString stringWithFormat:@"@%@ %@",[userDic objectForKey:@"name"],[messageBase.reply_comment objectForKey:@"text"]];
//    label1.isNeedAtAndPoundSign=YES;
//    [label1 setEmojiText:user];
    label1.text = user;
    label1.attributedText = [NSMutableAttributedString changeTextAttributed:label1.text withFontSize:15];
    label1.numberOfLines=0;
    label1.font=[UIFont systemFontOfSize:15];
    CGSize replySize=[self sizeWithString:label1.text font:label1.font];
    label1.frame=CGRectMake(10, 5, replySize.width, replySize.height+8);
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, replySize.height+100)];
    view.backgroundColor=[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [view addSubview:label1];
    
    [self addSubview:view];
    
    _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame=CGRectMake(10, CGRectGetMaxY(label1.frame)+7, 355, 75);
    _btn.backgroundColor=[UIColor whiteColor];

    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchDragExit];
    [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchUpInside];
    
   

            NSString *path=[messageBase.status objectForKey:@"thumbnail_pic"];
            NSURL *url=[NSURL URLWithString:path];
            NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
            NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
            imageV.image=[UIImage imageWithData:data];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame)+5, 5, 200, 30)];
            NSDictionary *dic=[messageBase.status objectForKey:@"user"];
            label2.text=[NSString stringWithFormat:@"@%@",[dic objectForKey:@"name"]];
            label2.font=[UIFont systemFontOfSize:14.3];
        UILabel *label3=[UILabel new];
    label3.font=[UIFont systemFontOfSize:12];
    label3.text=[messageBase.status objectForKey:@"text"];
    label3.textColor=[UIColor lightGrayColor];
    label3.numberOfLines=2;
    CGSize labelsize=[label3 sizeThatFits:CGSizeMake(280, 26)];
    label3.frame=CGRectMake(CGRectGetMaxX(imageV.frame)+5, CGRectGetMaxY(label2.frame)+5, labelsize.width, labelsize.height);
            [_btn addSubview:label2];
            [_btn addSubview:label3];
            [_btn addSubview:imageV];
    
    [self addSubview:_btn];
    

}
-(void)btnActionT:(UIButton *)btn{
    btn.backgroundColor=[UIColor whiteColor];
    FWBTalkController *tc=[FWBTalkController new];
    self.delegate=tc;
    [self.delegate pushMessage:_messageBase];
    
}
-(void)btnAction:(UIButton *)btn{
    btn.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
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

@end
