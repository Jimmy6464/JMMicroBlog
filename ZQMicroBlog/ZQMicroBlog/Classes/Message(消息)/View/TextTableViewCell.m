//
//  TextTableViewCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/30.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "TextTableViewCell.h"
#import "CellView.h"
#define theX 10

@interface TextTableViewCell()
{
    UIImageView *imageV;
}
@end
@implementation TextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setMessageBase:(FWBMessage *)messageBase
{
    NSString *text=messageBase.text;
    
    CellView *cellView=[[CellView alloc]initWithFrame:CGRectMake(0, 0, 375, [self sizeWithString:text].size.height+60)];
//    [cellView.btn removeFromSuperview];
    cellView.messageBase=messageBase;
    [self addSubview:cellView];
    
    _btn.frame=CGRectMake(300, 5, 52, 27);
    _btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_btn setBackgroundImage:[UIImage imageNamed:@"compose_photo_preview_seleted.png"] forState:UIControlStateNormal];
    [_btn setTintColor:[UIColor orangeColor]];
    [_btn setTitle:@"推广" forState:UIControlStateNormal];
    [cellView addSubview:_btn];
    
    NSDictionary *textDic=messageBase.retweeted_status;
    if (textDic) {
        NSDictionary *userDic=[textDic objectForKey:@"user"];
        UILabel *textLabel=[UILabel new];
        textLabel.numberOfLines=0;
        NSString *textString=[NSString stringWithFormat:@"@%@%@",[userDic objectForKey:@"name"],[textDic objectForKey:@"text"]];
        CGRect textHeight=[self sizeWithString:textString];
        textLabel.frame=CGRectMake(10, 0, textHeight.size.width, textHeight.size.height+20);
        textLabel.text=textString;

        UIButton *view=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        
        if ([textDic objectForKey:@"original_pic"]) {
            NSString *imagepath=[textDic objectForKey:@"original_pic"];
            NSURL *imageurl=[NSURL URLWithString:imagepath];
            NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
            NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
            UIImage *theimage=[UIImage imageWithData:data2];
            float scaNum=cellView.frame.size.width/theimage.size.width;
            imageV=[[UIImageView alloc]initWithFrame:CGRectMake(theX,CGRectGetMaxY(textLabel.frame), textLabel.frame.size.width, theimage.size.height*scaNum)];
            imageV.image=theimage;
            [view addSubview:imageV];
            view.frame=CGRectMake(0, CGRectGetMaxY(cellView.frame), 375, textLabel.frame.size.height+imageV.frame.size.height);
            _rowHeight=CGRectGetMaxY(imageV.frame);
            [self addSubview:view];
            
        }
        [view addSubview:textLabel];
    }
    
    
}
- (CGRect)sizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(365, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect;
}
@end
