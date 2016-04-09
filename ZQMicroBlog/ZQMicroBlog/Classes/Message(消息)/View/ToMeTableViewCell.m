//
//  ToMeTableViewCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "ToMeTableViewCell.h"
#import "ToMeViewController.h"
#import "CellView.h"
#define Thex 30
#define They 10
#define  Theweight 19
#define Theheight 19
#define weight 375
@interface ToMeTableViewCell()
{
    UIView *view;
    UILabel  *label1;
}
@end
@implementation ToMeTableViewCell

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
    
    _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _transmit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _discuss=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _spot=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [self addSubview:_transmit];
    [self addSubview:_discuss];
    [self addSubview:_spot];

}
-(void)setMessageBase:(FWBMessage *)messageBase
{
    _messageBase=messageBase;
    NSString *text=messageBase.text;
    CellView *cellView=[[CellView alloc]initWithFrame:CGRectMake(0, 0, 375, [self viewsizeWithString:text]+108)];
    [cellView.btn removeFromSuperview];
    cellView.messageBase=messageBase;
    [self addSubview:cellView];
    
    if ([messageBase.retweeted_status objectForKey:@"thumbnail_pic"]) {
        NSString *path=[messageBase.retweeted_status objectForKey:@"thumbnail_pic"];
        NSURL *url=[NSURL URLWithString:path];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        imageV.image=[UIImage imageWithData:data];
        NSDictionary *dic=[messageBase.retweeted_status objectForKey:@"user"];
        
        UILabel *label2=[[UILabel alloc]init];
        UILabel *label3=[[UILabel alloc]init];
        label2.text=[NSString stringWithFormat:@"@%@",[dic objectForKey:@"name"]];
        label2.font=[UIFont systemFontOfSize:14];
        label2.frame=CGRectMake(CGRectGetMaxX(imageV.frame)+5,4, 200, 30);
        
        label3.text=[messageBase.retweeted_status objectForKey:@"text"];
        label3.textColor=[UIColor lightGrayColor];
        label3.numberOfLines=2;
        CGSize labelsize=[label3 sizeThatFits:CGSizeMake(280, 26)];
        label3.font=[UIFont systemFontOfSize:12];
        label3.frame=CGRectMake(CGRectGetMaxX(imageV.frame)+5, CGRectGetMaxY(label2.frame)-8, 280,labelsize.height);
        
        CGFloat f=[self viewsizeWithString:text];
        _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn.frame=CGRectMake(10, f+50+7, 355, 75);
        _btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchDragExit];
        [_btn addTarget:self action:@selector(btnActionT:) forControlEvents:UIControlEventTouchUpInside];
        [_btn addSubview:label2];
        [_btn addSubview:label3];
        [_btn addSubview:imageV];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_btn];
        [self initThreeBtn:messageBase];
    }else{
        _transmit.frame=CGRectMake(0, CGRectGetMaxY(cellView.frame)+8, weight/3, 35);
        [_transmit setTitle:@"转发" forState:UIControlStateNormal];
        _transmit.tintColor=[UIColor lightGrayColor];
        _transmit.titleLabel.font=[UIFont systemFontOfSize:13];
        _transmit.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
        UIImageView *imagev1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_retweet"]];
        imagev1.frame=CGRectMake(Thex,They, Theweight, Theheight);
        [_transmit addSubview:imagev1];
        
        _discuss.frame=CGRectMake(CGRectGetMaxX(_transmit.frame), CGRectGetMaxY(cellView.frame)+8, weight/3, 35);
        UIImageView *imagev2= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_comment"]];
        imagev2.frame=CGRectMake(Thex,They, Theweight, Theheight);
        [_discuss setTitle:@"评论" forState:UIControlStateNormal];
        [_discuss addTarget:self action:@selector(discussAction:) forControlEvents:UIControlEventTouchUpInside];
        _discuss.tintColor=[UIColor lightGrayColor];
        _discuss.titleLabel.font=[UIFont systemFontOfSize:13];
        _discuss.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
        [_discuss addSubview:imagev2];
        
        _spot.frame=CGRectMake(CGRectGetMaxX(_discuss.frame), CGRectGetMaxY(cellView.frame)+8, weight/3, 35);
        UIImageView *imagev3= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_like"]];
        imagev3.frame=CGRectMake(Thex,They, Theweight, Theheight);
        if (messageBase.attitudes_count!=0) {
            [_spot setTitle:[NSString stringWithFormat:@"%ld",messageBase.attitudes_count] forState:UIControlStateNormal];
        }else{
            [_spot setTitle:@"赞" forState:UIControlStateNormal];
        }
        [_spot addTarget:self action:@selector(spotAction:) forControlEvents:UIControlEventTouchUpInside];
        _spot.tintColor=[UIColor lightGrayColor];
        _spot.titleLabel.font=[UIFont systemFontOfSize:13];
        _spot.titleEdgeInsets=UIEdgeInsetsMake(They-5, 10, 0, 0);
        [_spot addSubview:imagev3];
    
    }
    
}

//点赞
static bool fale=YES;
-(void)spotAction:(UIButton *)btn{
    UIImageView *imagev=[UIImageView new];
    for (UIView *iview in [btn subviews]) {
        if ([iview isMemberOfClass:[UIImageView class]]) {
            imagev=(UIImageView *)iview;
        }
    }
    if (fale) {
        [_spot setTitle:[NSString stringWithFormat:@"%ld",[_spot.currentTitle integerValue]+1] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.8 animations:^{
            imagev.image=[UIImage imageNamed:@"page_icon_like"];
            imagev.frame=CGRectMake(Thex,They, Theweight+8, Theheight+8);
            imagev.frame=CGRectMake(Thex,They, Theweight, Theheight);
        }];
        fale=NO;
    }else{
        if ([_spot.currentTitle integerValue]==1) {
            [_spot setTitle:@"赞" forState:UIControlStateNormal];
        }else{
        [_spot setTitle:[NSString stringWithFormat:@"%ld",[_spot.currentTitle integerValue]-1] forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.8 animations:^{
            imagev.image=[UIImage imageNamed:@"statusdetail_icon_like"];
            imagev.frame=CGRectMake(Thex,They, Theweight+8, Theheight+8);
            imagev.frame=CGRectMake(Thex,They, Theweight, Theheight);
        }];
        fale=YES;
    }
    
}
//评论
-(void)discussAction:(UIButton *)btn{
//    ToMeViewController *tc=[ToMeViewController new];
//    self.delegate=tc;
//    [self.delegate pushMessage:_messageBase];
}
-(void)btnActionT:(UIButton *)btn{
    _btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self.delegate pushMessage:_messageBase];
    
}
-(void)btnAction:(UIButton *)btn{
    _btn.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
}
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

-(void)initThreeBtn:(FWBMessage *)messageBase{
    _transmit.frame=CGRectMake(0, CGRectGetMaxY(_btn.frame)+8, weight/3, 35);
    [_transmit setTitle:@"转发" forState:UIControlStateNormal];
    _transmit.tintColor=[UIColor lightGrayColor];
    _transmit.titleLabel.font=[UIFont systemFontOfSize:13];
    _transmit.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
    UIImageView *imagev1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_retweet"]];
    imagev1.frame=CGRectMake(Thex,They, Theweight, Theheight);
    [_transmit addSubview:imagev1];
    
    _discuss.frame=CGRectMake(CGRectGetMaxX(_transmit.frame), CGRectGetMaxY(_btn.frame)+8, weight/3, 35);
    UIImageView *imagev2= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_comment"]];
    imagev2.frame=CGRectMake(Thex,They, Theweight, Theheight);
    [_discuss setTitle:@"评论" forState:UIControlStateNormal];
    [_discuss addTarget:self action:@selector(discussAction:) forControlEvents:UIControlEventTouchUpInside];
    _discuss.tintColor=[UIColor lightGrayColor];
    _discuss.titleLabel.font=[UIFont systemFontOfSize:13];
    _discuss.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
    [_discuss addSubview:imagev2];
    
    _spot.frame=CGRectMake(CGRectGetMaxX(_discuss.frame), CGRectGetMaxY(_btn.frame)+8, weight/3, 35);
    UIImageView *imagev3= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_like"]];
    imagev3.frame=CGRectMake(Thex,They, Theweight, Theheight);
    if (messageBase.attitudes_count!=0) {
        [_spot setTitle:[NSString stringWithFormat:@"%ld",messageBase.attitudes_count] forState:UIControlStateNormal];
    }else{
        [_spot setTitle:@"赞" forState:UIControlStateNormal];
    }
    [_spot addTarget:self action:@selector(spotAction:) forControlEvents:UIControlEventTouchUpInside];
    _spot.tintColor=[UIColor lightGrayColor];
    _spot.titleLabel.font=[UIFont systemFontOfSize:13];
    _spot.titleEdgeInsets=UIEdgeInsetsMake(They-5, 10, 0, 0);
    [_spot addSubview:imagev3];
}
@end
