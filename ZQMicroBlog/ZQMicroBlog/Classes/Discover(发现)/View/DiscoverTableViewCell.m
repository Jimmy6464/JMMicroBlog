//
//  DiscoverTableViewCell.m
//  ZQMicroBlog
//
//  Created by ibokan on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <UIKit/NSText.h>
#define width  375
#define height  80
#define fontSize 15
@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self subUI];
    }
    return self;
}

-(void)subUI{
    NSArray *array=@[@"#vivo X6#",@"#大学生调查#",@"#谢谢你出现在我的青春岁月里#",
                     @"热门话题"];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 5, 375/2-20, 30)];
        label.font=[UIFont systemFontOfSize:fontSize];
        UIImageView *bv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 1, 30)];
        bv.image=[UIImage imageNamed:@"message_toolbar_split"];
        
        UIImageView *bv1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, width/2-20, 1)];
        bv1.image=[UIImage imageNamed:@"compose_emotion_table_mid_selected"];
        label.text=array[i];
        if (i<2) {
            btn.frame=CGRectMake(i*width/2, 0, 375/2, height/2);
            if (i==1) {
                [btn addSubview:bv];
            }
        }else{
            btn.frame=CGRectMake((i-2)*width/2, height/2, 375/2, height/2);
            [btn addSubview:bv1];
            if (i==3) {
                [btn addSubview:bv];
            }
        }
        [btn addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
        [btn addSubview:label];
        [self addSubview:btn];
    }
    
    
}

-(void)btn1Action:(UIButton *)btn{
    btn.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
}
-(void)btn2Action:(UIButton *)btn{
    btn.backgroundColor=[UIColor whiteColor];
}
@end
