//
//  MicroBlogCell.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "MicroBlogCell.h"
#import "BlogDetailsController.h"
#import "ToolDock.h"
#import "PushTool.h"
#import "Statues.h"
#define LeftMargin 10
#define TopMargin 10
@interface MicroBlogCell()
/**
 *  原创微博视图
 */
@property (strong, nonatomic) OriginalBlogView *originalBlogV;
/**
 *  转发微博视图
 */
@property (strong, nonatomic) RetweetBlogView *retweetView;
/**
 *  工具条
 */
@property (strong, nonatomic) ToolDock *toolDock;
@end
@implementation MicroBlogCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置所有子控件
        [self setUpAllSubviews];
        //设置事件
        [self setUpEvent];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpAllFrames];
}
#pragma mark - 设置所有子控件
- (void)setUpAllSubviews
{
    //原创微博
    OriginalBlogView *original = [OriginalBlogView new];
    [self.contentView addSubview:original];
    _originalBlogV = original;
    
    //转发微博视图
    RetweetBlogView *retweet = [RetweetBlogView new];
    retweet.userInteractionEnabled = YES;
    [self.contentView addSubview:retweet];
    _retweetView = retweet;
    
    //工具条
    ToolDock *tool = [ToolDock new];
    [self.contentView addSubview:tool];
    _toolDock = tool;
    
}
#pragma mark - 重写数据模型set方法
- (void)setStatues:(Statues *)statues
{
    _statues = statues;
    [self setUpAllFrames];
}
#pragma mark - 设置所有控件的frame
- (void)setUpAllFrames
{
    //原创微博
    _originalBlogV.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, KeyWindow.bounds.size.height);
    _originalBlogV.status = _statues;
    _originalBlogV.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, _originalBlogV.originalH);
    
    //转发微博视图
    _retweetView.retweeted_status = _statues.retweeted_status;
    _retweetView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_originalBlogV.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, _retweetView.retweetHeight);
    
    //工具条
    _toolDock.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_retweetView.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, 44);
    _toolDock.status = self.statues;
    self.cellHeight = CGRectGetMaxY(_toolDock.frame);
    
}
#pragma mark - 设置label自适应行高
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000) options:NSStringDrawingTruncatesLastVisibleLine  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size;
}
+ (instancetype)microBlogCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"microBlogCell";
    MicroBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MicroBlogCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}
#pragma mark - 设置事件
- (void)setUpEvent
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetViewClick:)];
    [self.retweetView addGestureRecognizer:tap];
}
- (void)retweetViewClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s",__func__);
    BlogDetailsController *detail = [BlogDetailsController new];
    [PushTool pushController:detail byView:tap.view withObject:@{StatusKey:self.statues.retweeted_status}];
}

@end
