//
//  MySearchBarView.m
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MySearchBarView.h"

@implementation MySearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self subViews:frame];
    }
    return self;
}

-(void)subViews:(CGRect)frame{
    
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(frame.size.width/37, 5, frame.size.width-50, 30)];
    textField.layer.cornerRadius=5.0f;
    textField.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"message_voice_background"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"message_voice_background_highlighted"] forState:UIControlStateHighlighted];
    btn.frame=CGRectMake(CGRectGetMaxX(textField.frame), 0, 40, 40);
    
    [self addSubview:textField];
    [self addSubview:btn];
    
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *searchV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    searchV.image=[UIImage imageNamed:@"launcher_icon_search"];
    searchBtn.frame=CGRectMake(0, 3, 38, 20);
    [searchBtn addSubview:searchV];
    searchBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.placeholder=@"大家都在搜:热门话题";
    [textField setFont:[UIFont systemFontOfSize:14]];
    textField.leftView=searchBtn;

}

@end
