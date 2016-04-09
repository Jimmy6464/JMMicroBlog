//
//  RetweetBlogView.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "RetweetBlogView.h"
#import "PhotoesView.h"
#import "Statues.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
#import "URLTool.h"
#import "PushTool.h"
#import "DetailProfileController.h"
#import "BlogDetailsController.h"
#import "WebViewController.h"
#define LeftMargin 10
#define TopMargin 10

#define ALABEL_EXPRESSION @"(<[aA].*?>.+?</[aA]>)"
#define HREF_PROPERTY_IN_ALABEL_EXPRESSION @"(href\\s*=\\s*(?:\"([^\"]*)\"|\'([^\']*)\'|([^\"\'>\\s]+)))"
#define URL_EXPRESSION @"([hH][tT][tT][pP][sS]?:\\/\\/[^ ,'\">\\]\\)]*[^\\. ,'\">\\]\\)])"
#define AT_IN_WEIBO_EXPRESSION @"(@[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30})"
#define TOPIC_IN_WEIBO_EXPRESSION @"(#[^#]+#)"
@interface RetweetBlogView ()<UITextViewDelegate>
/**
 *  转发文本内容
 */
@property (nonatomic, strong) UILabel *contentLabel;
@property (strong, nonatomic) UITextView *contentView;
/**
 *  转发配图视图
 */
@property (nonatomic) PhotoesView *photosView;
@end
@implementation RetweetBlogView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.contentMode = UIViewContentModeScaleToFill;
        [self setImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        [self setHighlightedImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"]];
        //1.设置所有的子控件
        [self setUpAllSubviews];
    }
    return self;
}
#pragma mark - 设置所有的子控件
- (void)setUpAllSubviews
{
    //转发文本内容
    
    UITextView *contentV = [UITextView new];
    contentV.delegate = self;
    contentV.editable = NO;
    contentV.scrollEnabled = NO;
    contentV.userInteractionEnabled = YES;
    contentV.font = CellFont;
    contentV.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentPressed:)];
    [contentV addGestureRecognizer:tap];
    [self addSubview:contentV];
    _contentView = contentV;
    
    //转发配图视图
    PhotoesView *photosV = [PhotoesView new];
    [self addSubview:photosV];
    _photosView = photosV;
    
}
#pragma mark - 重写数据模型set方法,并调用设置frame方法
- (void)setRetweeted_status:(Statues *)retweeted_status
{
    _retweeted_status = retweeted_status;
    [self setUpAllFrames];
}
#pragma mark - 设置控件frame
- (void)setUpAllFrames
{
    //转发文本内容
    _contentView.text = [NSString stringWithFormat:@"@%@ : %@",_retweeted_status.user.name,_retweeted_status.text];
    CGSize contentS = [self.contentView sizeThatFits:CGSizeMake(KeyWindow.bounds.size.width - 2*LeftMargin, CGFLOAT_MAX)];
    _contentView.attributedText = [NSMutableAttributedString changeTextAttributed:_contentView.text withFontSize:20];
    _contentView.frame = CGRectMake(LeftMargin, TopMargin, contentS.width, contentS.height);
    

    //转发配图视图
    if (_retweeted_status.pic_urls.count) {
        _photosView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_contentView.frame), KeyWindow.bounds.size.width - 2 *LeftMargin, _photosView.viewH);
        _photosView.pic_urls = _retweeted_status.pic_urls;
        _photosView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_contentView.frame), KeyWindow.bounds.size.width - 2 *LeftMargin, _photosView.viewH);
        _photosView.hidden = NO;
        self.retweetHeight = CGRectGetMaxY(_photosView.frame);
    }else {
        _photosView.hidden = YES;
        self.retweetHeight = CGRectGetMaxY(_contentView.frame);
    }
    
}
#pragma mark - 设置label自适应行高
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000) options:NSStringDrawingTruncatesLastVisibleLine  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSString *urlString = [URL absoluteString];
    if ( [urlString isEqualToString:@"userName"] || [urlString isEqualToString:@"topic"]) {
        //跳转到user
        DetailProfileController *blog = [DetailProfileController new];
        [PushTool pushController:blog byView:textView withObject:@{@"status":self.retweeted_status}];
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
- (void)contentPressed:(UITapGestureRecognizer *)tap
{
    BlogDetailsController *detail = [BlogDetailsController new];
    [PushTool pushController:detail byView:tap.view withObject:@{StatusKey:self.retweeted_status}];
}
@end
