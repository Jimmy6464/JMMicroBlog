//
//  ReflashCell.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/10.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ReflashCell.h"
@interface ReflashCell()
/**
 *  小菊花
 */
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
/**
 *  label
 */
@property (strong, nonatomic) UILabel *lbl;
@end
@implementation ReflashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenCell) name:@"hiddenReflash" object:nil];
        
    }
    return self;
}
- (void)setUpSubviews
{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]init];
    activity.center = self.contentView.center;
    activity.hidesWhenStopped = YES;
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activity startAnimating];
    [self.contentView addSubview:activity];
    _activityIndicator = activity;
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(activity.frame) + 20, 10, 100, 30)];
    lbl.text = @"Loading.....";
    lbl.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lbl];
    _lbl = lbl;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"reflashCell";
    ReflashCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell  = [[ReflashCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}
- (void)hiddenCell
{
    [_activityIndicator stopAnimating];
    _lbl.text = @"没有评论";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hiddenReflash" object:nil];
}

@end
