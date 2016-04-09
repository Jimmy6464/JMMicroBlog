//
//  CommentCell.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+ChangeTextAttributed.h"
#import "SinglePhotoView.h"
@interface CommentCell ()
/**
 *  头像
 */
@property (strong, nonatomic) UIImageView *avatorImage;
@property (strong, nonatomic) UIImageView *identifierIcon;
/**
 *  用户名
 */
@property (strong, nonatomic) UILabel *screenName;
/**
 *  创建时间
 */
@property (strong, nonatomic) UILabel *creat_at;
/**
 *  评论内容
 */
@property (strong, nonatomic) UITextView *textLbl;


@end
@implementation CommentCell
- (UIImageView *)identifierIcon
{
    if (_identifierIcon == nil) {
        UIImageView *vipImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_vip"]];
        [self.avatorImage addSubview:vipImage];
        _identifierIcon = vipImage;
    }
    return _identifierIcon;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}
#pragma mark - 设置子控件
- (void)setUpSubviews
{
    //头像
    UIImageView *avator = [[UIImageView alloc]init];
    [self.contentView addSubview:avator];
    _avatorImage = avator;
    
    //用户昵称
    UILabel *lbl = [UILabel new];
    [self.contentView addSubview:lbl];
    _screenName = lbl;
    
    //创建时间
    UILabel *create = [UILabel new];
    [self.contentView addSubview:create];
    _creat_at = create;
    
    //评论内容
    UITextView *contentV = [UITextView new];
    contentV.editable = NO;
    contentV.scrollEnabled = NO;
    contentV.backgroundColor = [UIColor clearColor];
    [self addSubview:contentV];
    _textLbl = contentV;
}

#pragma mark - 创建cell
+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *cellId = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}
#pragma mark - 设置数据
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    
    //头像
    [self.avatorImage sd_setImageWithURL:comment.user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.avatorImage.frame = CGRectMake(LeftMargin, TopMargin, 40, 40);
    if ([self.comment.user.verified isEqualToString:@"1"]) {
        CGRect vipRect = self.identifierIcon.frame;
        CGRect rect = _avatorImage.frame;
        self.identifierIcon.frame = CGRectMake(rect.size.width - vipRect.size.width, rect.size.height - vipRect.size.height, vipRect.size.width, vipRect.size.height);
    }
    
    //昵称
    self.screenName.text = _comment.user.name;
    self.screenName.attributedText = [NSMutableAttributedString changeTextAttributed:_screenName.text withFontSize:15];
    CGSize nameSize = [self.screenName sizeThatFits:CGSizeMake(320, 30)];
    self.screenName.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, TopMargin, nameSize.width, nameSize.height);
    
    //创建时间
    self.creat_at.text = _comment.created_at;
    self.creat_at.textColor = [UIColor lightGrayColor];
    self.creat_at.font = [UIFont systemFontOfSize:12];
    self.creat_at.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, CGRectGetMaxY(self.screenName.frame), 100, 30);
    
    //评论内容
    /*
     self.textLbl.text = _comment.text;
     self.textLbl.numberOfLines = 0;
     self.textLbl.attributedText = [NSMutableAttributedString changeTextAttributed:_textLbl.text withFontSize:15];
     CGSize textSize = [self.textLbl sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)];
     self.textLbl.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, CGRectGetMaxY(self.creat_at.frame), textSize.width, textSize.height);
     self.cellH = CGRectGetMaxY(self.textLbl.frame) + TopMargin;
     */
    _textLbl.text = self.comment.text;
    _textLbl.attributedText = [NSMutableAttributedString changeTextAttributed:_textLbl.text withFontSize:15];
    CGSize contentS = [_textLbl sizeThatFits:CGSizeMake(KeyWindow.bounds.size.width - CGRectGetMaxX(_avatorImage.frame) - LeftMargin, CGFLOAT_MAX)];
    self.textLbl.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + LeftMargin, CGRectGetMaxY(self.creat_at.frame), contentS.width, contentS.height);
    self.cellH = CGRectGetMaxY(_textLbl.frame);
    
}
@end
