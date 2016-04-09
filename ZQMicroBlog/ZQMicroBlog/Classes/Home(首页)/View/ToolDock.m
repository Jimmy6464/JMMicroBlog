//
//  ToolDock.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ToolDock.h"
#import "Statues.h"
#import "BlogDetailsController.h"
#import "PushTool.h"
#import "RetweetDetailView.h"
#import "BaseMicorologEditViewController.h"
#import "HomeController.h"
@interface ToolDock ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divides;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation ToolDock

- (NSMutableArray *)divides
{
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setUpAllSubviews
{
    // 添加转发
    _retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"] atIndex:100001];
    
    // 添加评论
    _comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"] atIndex:100002];
    
    // 添加赞
    _unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"] atIndex:100003];
    
    // 添加分割线
    [self setUpDivide];
}
- (void)setUpDivide
{
    for (int i = 0; i < 2; i++) {
        UIImageView *divide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divide];
        [self.divides addObject:divide];
    }
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image atIndex:(NSInteger) index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self.btns addObject:btn];
    
    [self addSubview:btn];
    return btn;
}
- (void)btnPressed:(UIButton *)btn
{
    [self.delegate btnPressedAtIndex:btn.tag];
    UIViewController *result ;
    id responder = [btn nextResponder];
    while (true) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            result = responder;
            break;
        }else {
            responder = [responder nextResponder];
        }
    }
    UIImageView *imageV = (UIImageView *)btn.superview;
    if ([result isKindOfClass:[HomeController class]] && ![btn.currentTitle intValue]) {
        [self goToDoOperation:imageV andBtn:btn];
        return;
    }
    
    if (![result isKindOfClass:[BlogDetailsController class]] || [imageV.superview isKindOfClass:[RetweetDetailView class]]) {
        BlogDetailsController *detail = [BlogDetailsController new];
        [PushTool pushController:detail byView:btn withObject:@{StatusKey:self.status,@"index":@(btn.tag)}];
        return;
    }
    
    if (imageV.tag == 1478){
        [self goToDoOperation:imageV andBtn:btn];
        return;
    }
    
    NSLog(@"%s",__func__);
}
- (void)goToDoOperation:(UIView *)view andBtn:(UIButton *)btn
{
    NSString *title = [self getNavTitleWithBtn:btn];
    BaseMicorologEditViewController *base =[[BaseMicorologEditViewController alloc]initWithTitleName:title];
    base.microlongId = self.status.id;
    [PushTool presentController:base byView:view withObject:@{StatusKey:self.status}];
}
- (NSString *)getNavTitleWithBtn:(UIButton *)btn
{
    NSString *title;
    switch (btn.tag) {
        case 100001:
            //转发
            title = [NSString stringWithFormat:@"%@微博",btn.currentTitle];
            break;
        case 100002:
            //评论
            title = [NSString stringWithFormat:@"发%@",btn.currentTitle];
            break;
        case 100003:
            //赞
            NSLog(@"赞");
            break;
            
        default:
            break;
    }
    return title;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮位置
    NSUInteger btnCount = self.btns.count;
    CGFloat w = self.frame.size.width / btnCount;
    CGFloat h = self.frame.size.height;
    CGFloat x = 0;
    for (int i = 0; i < btnCount; i++) {
        x = i * w;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, 0, w, h);
    }
    
    // 设置分割线位置
    NSUInteger divideCount = self.divides.count;
    for (int i = 0;i < divideCount ; i ++) {
        UIImageView * divideV = self.divides[i];
        UIButton *btn = self.btns[i + 1];
        CGRect rect = divideV.frame;
        divideV.frame = CGRectMake(btn.frame.origin.x, rect.origin.y, rect.size.width, rect.size.height);

    }
    
    
}

- (void)setStatus:(Statues *)status
{
    _status = status;
    if (self.tag == 1478) {
        return;
    }
    // 转发
    [self setBtnTitleWithCount:status.reposts_count originalTitle:@"转发" withBtn:_retweet];
    // 评论
    [self setBtnTitleWithCount:status.comments_count originalTitle:@"评论" withBtn:_comment];
    // 赞
    [self setBtnTitleWithCount:status.attitudes_count originalTitle:@"赞" withBtn:_unlike];
    
    
}

- (void)setBtnTitleWithCount:(int)count originalTitle:(NSString *)title withBtn:(UIButton *) btn
{
    if (count) {
        
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",floatCount];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
            [btn setTitle:title forState:UIControlStateNormal];
        }else{
            
            [btn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        }
        
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end