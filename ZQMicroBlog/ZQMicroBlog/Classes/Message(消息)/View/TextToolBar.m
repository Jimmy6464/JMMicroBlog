//
//  TextToolBar.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/30.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "TextToolBar.h"
#define Thex 30
#define They 10
#define  Theweight 19
#define Theheight 19
#define Weight 375
#define Height 667
@implementation TextToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self subAllView];
    }
    return self;
}

-(void)subAllView{
    
    
    _transmit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _discuss=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _spot=[UIButton buttonWithType:UIButtonTypeRoundedRect];

    
    _transmit.frame=CGRectMake(0,0, Weight/3, 35);
    [_transmit setTitle:@"转发" forState:UIControlStateNormal];
    _transmit.tintColor=[UIColor blackColor];
    _transmit.titleLabel.font=[UIFont systemFontOfSize:13];
    _transmit.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
    UIImageView *imagev1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_retweet"]];
    imagev1.frame=CGRectMake(Thex,They, Theweight, Theheight);
    [_transmit addSubview:imagev1];
    
    _discuss.frame=CGRectMake(CGRectGetMaxX(_transmit.frame),0, Weight/3, 35);
    UIImageView *imagev2= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_comment"]];
    imagev2.frame=CGRectMake(Thex,They, Theweight, Theheight);
    [_discuss setTitle:@"评论" forState:UIControlStateNormal];
    [_discuss addTarget:self action:@selector(discussAction:) forControlEvents:UIControlEventTouchUpInside];
    _discuss.tintColor=[UIColor blackColor];
    _discuss.titleLabel.font=[UIFont systemFontOfSize:13];
    _discuss.titleEdgeInsets=UIEdgeInsetsMake(They-5, 19, 0, 0);
    [_discuss addSubview:imagev2];
    
    _spot.frame=CGRectMake(CGRectGetMaxX(_discuss.frame), 0, Weight/3, 35);
    UIImageView *imagev3= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_icon_like"]];
    imagev3.frame=CGRectMake(Thex,They, Theweight, Theheight);
    [_spot setTitle:@"赞" forState:UIControlStateNormal];
    [_spot addTarget:self action:@selector(spotAction:) forControlEvents:UIControlEventTouchUpInside];
    _spot.tintColor=[UIColor blackColor];
    _spot.titleLabel.font=[UIFont systemFontOfSize:13];
    _spot.titleEdgeInsets=UIEdgeInsetsMake(They-5, 10, 0, 0);
    [_spot addSubview:imagev3];
    
    NSArray *btnArray=[NSArray arrayWithObjects:_transmit,_discuss,_spot, nil];
    NSMutableArray *barBtnArray=[NSMutableArray new];
    for (int i=0; i<3; i++) {
        UIBarButtonItem *barItem=[[UIBarButtonItem alloc]initWithCustomView:btnArray[i]];
        [barBtnArray addObject:barItem];
    }
    self.items=barBtnArray;
    [self setBackgroundColor:[UIColor whiteColor]];
}

-(void)discussAction:(UIButton *)btn{

}
static bool fale=YES;
-(void)spotAction:(UIButton *)btn{
    UIImageView *imagev=[UIImageView new];
    for (UIView *iview in [btn subviews]) {
        if ([iview isMemberOfClass:[UIImageView class]]) {
            imagev=(UIImageView *)iview;
        }
    }
    if (fale) {
        [UIView animateWithDuration:0.8 animations:^{
            imagev.frame=CGRectMake(Thex,They, Theweight+8, Theheight+8);
            imagev.image=[UIImage imageNamed:@"page_icon_like"];
            imagev.frame=CGRectMake(Thex,They, Theweight, Theheight);
        }];
        fale=NO;
    }else{
        [UIView animateWithDuration:0.8 animations:^{
            imagev.frame=CGRectMake(Thex,They, Theweight+8, Theheight+8);
            imagev.image=[UIImage imageNamed:@"statusdetail_icon_like"];
            imagev.frame=CGRectMake(Thex,They, Theweight, Theheight);
        }];
        fale=YES;
    }
    
}

@end
