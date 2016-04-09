//
//  OriginalBlogView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "OriginalBlogView.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
#import "URLTool.h"
#import "PushTool.h"
#import "DetailProfileController.h"
#import "BlogDetailsController.h"
#import "WebViewController.h"



#define ALABEL_EXPRESSION @"(<[aA].*?>.+?</[aA]>)"
#define HREF_PROPERTY_IN_ALABEL_EXPRESSION @"(href\\s*=\\s*(?:\"([^\"]*)\"|\'([^\']*)\'|([^\"\'>\\s]+)))"
#define URL_EXPRESSION @"([hH][tT][tT][pP][sS]?:\\/\\/[^ ,'\">\\]\\)]*[^\\. ,'\">\\]\\)])"
#define AT_IN_WEIBO_EXPRESSION @"(@[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30})"
#define TOPIC_IN_WEIBO_EXPRESSION @"(#[^#]+#)"
@interface OriginalBlogView ()<UITextViewDelegate>
/**
 *  头像
 */
@property (strong, nonatomic) UIImageView *avatorImage;
/**
 *  身份认证图
 */
@property (nonatomic,strong) UIImageView *identifierIcon;
/**
 *  昵称
 */
@property (strong, nonatomic) UILabel *screenNameLable;
/**
 *  vip图标
 */
@property (strong, nonatomic) UIButton *vipBtn;
/**
 *  更多图标
 */
@property (strong, nonatomic) UIButton *moreBtn;
/**
 *  创建时间
 */
@property (strong, nonatomic) UILabel *creatTime;
/**
 *  创建来源
 */
@property (strong, nonatomic) UILabel *soureFrom;
/**
 *  本文内容
 */
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UITextView *contentView;
@end
@implementation OriginalBlogView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置控件
        [self setUpSubviews];
        
        [self setUpEvent];
    }
    return self;
}
- (UIImageView *)identifierIcon
{
    if (_identifierIcon == nil) {
        UIImageView *vipImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_vip"]];
        [self.avatorImage addSubview:vipImage];
        _identifierIcon = vipImage;
    }
    return _identifierIcon;
}
#pragma mark - 设置子控件
- (void)setUpSubviews
{
    //头像
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.userInteractionEnabled = YES;
    [self addSubview:imageV];
    _avatorImage = imageV;
    
    //昵称
    UILabel *nameLbl = [UILabel new];
    nameLbl.userInteractionEnabled = YES;
    [self addSubview:nameLbl];
    _screenNameLable = nameLbl;
    
    //会员图标
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    _vipBtn = btn;
    
    //更多图标
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:moreBtn];
    _moreBtn = moreBtn;
    
    
    //创建时间
    UILabel *timeLbl = [UILabel new];
    [timeLbl setTextColor:[UIColor orangeColor]];
    [self addSubview:timeLbl];
    _creatTime = timeLbl;
    
    //来源
    UILabel *sourceLbl = [UILabel new];
    [self addSubview:sourceLbl];
    _soureFrom = sourceLbl;
    
    
    UITextView *contentV = [UITextView new];
    contentV.delegate = self;
    contentV.editable = NO;
    contentV.scrollEnabled = NO;
    contentV.font = CellFont;
    contentV.backgroundColor = [UIColor clearColor];
    [self addSubview:contentV];
    _contentView = contentV;

}
#pragma mark - 设置frames
- (void)setUpFrames
{
    //头像
    [_avatorImage sd_setImageWithURL:self.status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    _avatorImage.frame = CGRectMake(LeftMargin, TopMargin, 50, 50);
    //身份认证判断
    if ([self.status.user.verified isEqualToString:@"1"]) {
        CGRect vipRect = self.identifierIcon.frame;
        CGRect rect = _avatorImage.frame;
        self.identifierIcon.frame = CGRectMake(rect.size.width - vipRect.size.width, rect.size.height - vipRect.size.height, vipRect.size.width, vipRect.size.height);
    }
    
    //昵称
    _screenNameLable.text = _status.user.name;
    CGSize nameS = [self sizeWithString:_screenNameLable.text font:CellFont];
    _screenNameLable.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, TopMargin, nameS.width, nameS.height);
    
    //会员图标
    [_vipBtn setImage:[UIImage imageNamed:@"common_icon_membership"] forState:UIControlStateNormal];
    _vipBtn.frame = CGRectMake(CGRectGetMaxX(_screenNameLable.frame) + LeftMargin, TopMargin, 20, 20);
    
    //更多图标
    _moreBtn.frame = CGRectMake(KeyWindow.bounds.size.width - LeftMargin*3, TopMargin, 20, 20);
    
    
    //创建时间
    _creatTime.text = self.status.created_at;
    CGSize timeS = [self sizeWithString:_creatTime.text font:CellFont];
    _creatTime.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, CGRectGetMaxY(_avatorImage.frame) - TopMargin*2, timeS.width, timeS.height);
    
    //来源
    _soureFrom.text = self.status.source;
    CGSize sourceS = [self sizeWithString:_soureFrom.text font:CellFont];
    CGFloat width = (sourceS.width +CGRectGetMaxX(_creatTime.frame)) > KeyWindow.bounds.size.width ? (KeyWindow.bounds.size.width - CGRectGetMaxX(_creatTime.frame) - LeftMargin) : sourceS.width;
    _soureFrom.frame = CGRectMake(CGRectGetMaxX(_creatTime.frame), CGRectGetMaxY(_avatorImage.frame) - TopMargin*2, width, sourceS.height);
    
    //内容
    _contentView.text = self.status.text;
    _contentView.attributedText = [NSMutableAttributedString changeTextAttributed:_contentView.text withFontSize:20];
    CGSize contentS = [_contentView sizeThatFits:CGSizeMake(KeyWindow.bounds.size.width - 2*LeftMargin, CGFLOAT_MAX)];
    _contentView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_avatorImage.frame) + TopMargin, contentS.width, contentS.height);
    self.originalH = CGRectGetMaxY(_contentView.frame);
    
}
#pragma mark - 重写set方法
- (void)setStatus:(Statues *)status
{
    _status = status;
    [self setUpFrames];
}
#pragma mark - 计算自适应行高
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000) options:NSStringDrawingTruncatesLastVisibleLine  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size;
}
#pragma mark - 设置事件
- (void)setUpEvent
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToProfile:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToProfile:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentPressed:)];
    [self.avatorImage addGestureRecognizer:tap1];
    [self.screenNameLable addGestureRecognizer:tap];
    [self.contentView addGestureRecognizer:tap2];
    
    [_moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickToProfile:(UITapGestureRecognizer *)tap
{
    DetailProfileController *detail = [DetailProfileController new];
    [PushTool pushController:detail byView:tap.view withObject:@{StatusKey:self.status}];
    NSLog(@"%s",__func__);
}
- (void)moreBtnPressed:(UIButton *)btn
{
    NSLog(@"%s",__func__);
}
- (void)contentPressed:(UITapGestureRecognizer *)tap
{
    UIViewController *result ;
    id responder = [tap.view nextResponder];
    while (true) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            result = responder;
            break;
        }else {
            responder = [responder nextResponder];
        }
    }
    if (![result isKindOfClass:[BlogDetailsController class]]) {
        BlogDetailsController *detail = [BlogDetailsController new];
        [PushTool pushController:detail byView:tap.view withObject:@{StatusKey:self.status}];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSString *urlString = [URL absoluteString];
    
    if ( [urlString isEqualToString:@"userName"] || [urlString isEqualToString:@"topic"]) {
        //跳转到user
        DetailProfileController *blog = [DetailProfileController new];
        [PushTool pushController:blog byView:textView withObject:@{@"status":self.status}];
    }else {
        [URLTool getLongURlwithShortURL:urlString success:^(NSString *longURL) {
            NSURL *long_url = [NSURL URLWithString:longURL];
            WebViewController *web = [[WebViewController alloc]init];
            [PushTool pushController:web byView:textView withObject:@{@"goToSearch":long_url}];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    return NO;
}
@end
