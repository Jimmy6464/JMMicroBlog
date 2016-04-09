//
//  ProfileCellTableViewCell.m
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ProfileCellTableViewCell.h"

@implementation ProfileCellTableViewCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setProfileData:(ProfileData *)profileData{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 64, 64)];
    imageView.image=[UIImage imageWithData:profileData.avatar_largeData];
    
    NSString *userName=profileData.name;
    CGRect rect=[self sizeWithString:userName andFont:[UIFont systemFontOfSize:15]];
    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+8,CGRectGetMinY(imageView.frame)+8, rect.size.width+15, rect.size.height)];
    namelabel.text=userName;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(CGRectGetMaxX(namelabel.frame)+2, CGRectGetMinY(imageView.frame)+7, (rect.size.height-3)*3.5, rect.size.height+3);
    [btn setImage:[UIImage imageNamed:@"userinfo_membership_expired"] forState:UIControlStateNormal];
    
    NSString *detailText=profileData.Description;
    CGRect detailRect=[self sizeWithString:detailText andFont:[UIFont systemFontOfSize:10]];
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+8, CGRectGetMaxY(namelabel.frame)+6, detailRect.size.width+200, 28)];
    detaillabel.numberOfLines=0;
    detaillabel.textColor=[UIColor lightGrayColor];
    detaillabel.font=[UIFont systemFontOfSize:13];
    detaillabel.text=[NSString stringWithFormat:@"简介:%@",detailText];

    [self addSubview:imageView];
    [self addSubview:namelabel];
    [self addSubview:btn];
    [self addSubview:detaillabel];
}

-(CGRect)sizeWithString:(NSString *)string andFont:(UIFont *)font
{
    CGRect rect=[string boundingRectWithSize:CGSizeMake(360, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
}

@end
