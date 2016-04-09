//
//  DetailBlogCell.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "DetailBlogCell.h"
#import "OriginalBlogView.h"
#import "RetweetDetailView.h"
#import "PhotoesView.h"
#import "PushTool.h"
#import "BlogDetailsController.h"
@interface DetailBlogCell ()
@property (nonatomic, strong) OriginalBlogView *originalBlogView;
@property (nonatomic, strong) RetweetDetailView *retweetBlogView;
@property (nonatomic, strong) PhotoesView *phototesView;
@end
@implementation DetailBlogCell
- (PhotoesView *)phototesView
{
    if (_phototesView == nil) {
        PhotoesView *photoV = [[PhotoesView alloc] init];
        [self.contentView addSubview:photoV];
        _phototesView = photoV;
    }
    return _phototesView;
}
- (OriginalBlogView *)originalBlogView
{
    if (_originalBlogView == nil) {
        OriginalBlogView *original = [OriginalBlogView new];
        [self.contentView addSubview:original];
        _originalBlogView = original;
    }
    return _originalBlogView;
}
- (RetweetDetailView *)retweetBlogView
{
    if (_retweetBlogView == nil) {
        RetweetDetailView *retweet = [RetweetDetailView new];
        retweet.userInteractionEnabled = YES;
        [self.contentView addSubview:retweet];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retweetBlogViewPressed:)];
        [retweet addGestureRecognizer:tap];
        _retweetBlogView = retweet;
    }
    return _retweetBlogView;
}
- (void)setStatues:(Statues *)statues
{
    _statues = statues;
    
   self.originalBlogView.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, KeyWindow.bounds.size.height);
    _originalBlogView.status = _statues;
    _originalBlogView.frame = CGRectMake(0, 0, KeyWindow.bounds.size.width, _originalBlogView.originalH);
    
    self.cellHeight = CGRectGetMaxY(_originalBlogView.frame);
    if (_statues.retweeted_status) {
        
         self.retweetBlogView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_originalBlogView.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, _retweetBlogView.retweetHeight);
        _retweetBlogView.retweeted_status = _statues.retweeted_status;
        _retweetBlogView.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_originalBlogView.frame) + TopMargin, KeyWindow.bounds.size.width - 2 * LeftMargin, _retweetBlogView.retweetHeight);
        self.cellHeight = CGRectGetMaxY(_retweetBlogView.frame) + TopMargin;
    }else {
        if (self.statues.pic_urls.count != 0) {
            self.phototesView.frame = CGRectMake(LeftMargin, TopMargin + CGRectGetMaxY(_originalBlogView.frame), KeyWindow.bounds.size.width - LeftMargin*2, _phototesView.viewH);
            
            _phototesView.pic_urls = self.statues.pic_urls;
            
            _phototesView.frame = CGRectMake(LeftMargin, TopMargin + CGRectGetMaxY(_originalBlogView.frame), KeyWindow.bounds.size.width - LeftMargin*2, _phototesView.viewH);
            _phototesView.hidden = NO;
            self.cellHeight = CGRectGetMaxY(_phototesView.frame) + TopMargin;
        }
    }
    
}
+ (instancetype)cellWithTabView:(UITableView *)tableView
{
    static NSString * cellId = @"DetailCell";
    DetailBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DetailBlogCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}
- (void)retweetBlogViewPressed:(UITapGestureRecognizer *)tap
{
    BlogDetailsController *detail = [BlogDetailsController new];
    [PushTool pushController:detail byView:tap.view withObject:@{StatusKey:self.statues.retweeted_status}];
}
@end
