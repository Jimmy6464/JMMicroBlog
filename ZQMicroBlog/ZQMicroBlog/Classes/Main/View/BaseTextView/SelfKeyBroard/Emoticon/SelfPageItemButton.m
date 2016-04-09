//
//  SelfPageItemButton.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "SelfPageItemButton.h"

@implementation SelfPageItemButton
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title andNum:(NSInteger)num
{
    if (self = [super init]) {
        self.frame = frame ;
        self.tag = num ;
        self.titleLabel.text = title;
        self.userInteractionEnabled = YES ;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[[UIColor alloc]initWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.backgroundColor = [[UIColor alloc]initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonDown:) name:@"buttonDown" object:nil];
        [self addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    return self;
}
-(void)buttonUp
{
    [self setTitleColor:[[UIColor alloc]initWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.backgroundColor = [[UIColor alloc]initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.titleLabel.text,@"title", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonDown" object:nil userInfo:dic];
}
-(void)buttonDown:(NSNotification *)nf
{
    NSDictionary *dic = [nf userInfo];
    if (![[dic objectForKey:@"title"]isEqualToString:self.titleLabel.text]) {
        [self setTitleColor:[[UIColor alloc]initWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.backgroundColor = [[UIColor alloc]initWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
        
    }
}
-(void)btnAction:(UIButton *)sender
{
    [self buttonUp];
    [self.spiDelegate addAciton:self];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"buttonDown" object:nil];
}
@end
