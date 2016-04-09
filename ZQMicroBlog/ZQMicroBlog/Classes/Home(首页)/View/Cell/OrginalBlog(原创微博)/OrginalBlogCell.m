//
//  OrginalBlogCell.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "OrginalBlogCell.h"
#import "ToolDock.h"
#import "Statues.h"
#import "PhotoesView.h"

#define LeftMargin 10 
#define TopMargin 10

@interface OrginalBlogCell()

/**
 *  配图view
 */
@property (strong, nonatomic) PhotoesView *photoesView;
/**
 *  工具条
 */
@property (strong, nonatomic) ToolDock *toolDock;

@end
@implementation OrginalBlogCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置所有子控件
        [self setUpAllSubviews];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpAllFrames];
}
#pragma mark - 重写statues的set方法，同时设置控件的frame
- (void)setStatues:(Statues *)statues
{
    _statues = statues;
    [self setUpAllFrames];
}
#pragma mark - 初始化cell
+ (OrginalBlogCell *)orginalBlogCellWithView:(UITableView *)tableView
{
    static NSString *ID = @"OrginalBlogCell";
    OrginalBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OrginalBlogCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark - 设置所有子控件
- (void)setUpAllSubviews
{
    //原创微博
    OriginalBlogView *original = [OriginalBlogView new];
    [self.contentView addSubview:original];
    _originalBlogV = original;
    
    //配图
    PhotoesView *photosV = [PhotoesView new];
    [self.contentView addSubview:photosV];
    _photoesView = photosV;
    
    //工具条
    ToolDock *tool = [ToolDock new];
    [self.contentView addSubview:tool];
    _toolDock = tool;
    
}

#pragma mark - 设置子控件的frame
- (void)setUpAllFrames
{
    //原创微博
    _originalBlogV.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, KeyWindow.bounds.size.height);
    _originalBlogV.status = _statues;
    _originalBlogV.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, _originalBlogV.originalH);

    
    //配图
    if (_statues.pic_urls.count) {
        
        _photoesView.frame = CGRectMake(LeftMargin, TopMargin + CGRectGetMaxY(_originalBlogV.frame), KeyWindow.bounds.size.width - LeftMargin*2, _photoesView.viewH);
        
        _photoesView.pic_urls = self.statues.pic_urls;
        
        _photoesView.frame = CGRectMake(LeftMargin, TopMargin + CGRectGetMaxY(_originalBlogV.frame), KeyWindow.bounds.size.width - LeftMargin*2, _photoesView.viewH);
        _photoesView.hidden = NO;
        
        _toolDock.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_photoesView.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, 44);
        
        
    }else {
        _photoesView.hidden = YES;
        _toolDock.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_originalBlogV.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, 44);
    }
    _toolDock.status = self.statues;
    self.cellHeight = CGRectGetMaxY(_toolDock.frame) ;
    
}
#pragma mark - 计算自适应行高
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000) options:NSStringDrawingTruncatesLastVisibleLine  |NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName: font}
        context:nil];
    return rect.size;
}



@end
