//
//  RetweetDetailView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "RetweetDetailView.h"
#import "ToolDock.h"
#import "PhotoesView.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
@interface RetweetDetailView()<UITextViewDelegate>
/**
 *  转发文本内容
 */
@property (strong, nonatomic) UITextView *contentView;
/**
 *  转发配图视图
 */
@property (nonatomic) PhotoesView *photosView;
/**
 *  小工具条
 */
@property (nonatomic, strong) ToolDock *toolDock;
@end
@implementation RetweetDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleToFill;
        [self setImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        [self setHighlightedImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"]];

        [self setUpSubviews];
    }
    return self;
}
- (void)setUpSubviews
{
    //内容
    UITextView *contentV = [UITextView new];
    contentV.delegate = self;
    contentV.editable = NO;
    contentV.scrollEnabled = NO;
    contentV.userInteractionEnabled = YES;
    contentV.font = CellFont;
    contentV.backgroundColor = [UIColor clearColor];
    [self addSubview:contentV];
    _contentView = contentV;
    
    //转发配图视图
    PhotoesView *photosV = [PhotoesView new];
    [self addSubview:photosV];
    _photosView = photosV;
    
    ToolDock *tool = [[ToolDock alloc]init];
    [self addSubview:tool];
    _toolDock = tool;
   
}
- (void)setRetweeted_status:(Statues *)retweeted_status
{
    _retweeted_status = retweeted_status;
    [self setUpFrame];
    
}
- (void)setUpFrame
{
    //内容
    _contentView.text = [NSString stringWithFormat:@"@%@ : %@",_retweeted_status.user.name,_retweeted_status.text];
    CGSize contentS = [self.contentView sizeThatFits:CGSizeMake(KeyWindow.bounds.size.width - 2*LeftMargin, CGFLOAT_MAX)];
    _contentView.attributedText = [NSMutableAttributedString changeTextAttributed:_contentView.text withFontSize:20];
    _contentView.frame = CGRectMake(LeftMargin, TopMargin, contentS.width, contentS.height);
    
    
    CGFloat y = CGRectGetMaxY(_contentView.frame);
    //转发配图视图
    if (_retweeted_status.pic_urls.count) {
        _photosView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_contentView.frame), KeyWindow.bounds.size.width - 2 *LeftMargin, _photosView.viewH);
        _photosView.pic_urls = _retweeted_status.pic_urls;
        _photosView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_contentView.frame), KeyWindow.bounds.size.width - 2 *LeftMargin, _photosView.viewH);
        _photosView.hidden = NO;
        self.retweetHeight = CGRectGetMaxY(_photosView.frame);
        y = CGRectGetMaxY(_photosView.frame);
    }else {
        _photosView.hidden = YES;
        self.retweetHeight = CGRectGetMaxY(_contentView.frame);
    }
    
    //工具条
    self.toolDock.frame = CGRectMake(KeyWindow.center.x, y + TopMargin, self.center.x - LeftMargin*2 , 33);
    self.toolDock.status = self.retweeted_status;

    self.retweetHeight += 33 + TopMargin;
}
@end
