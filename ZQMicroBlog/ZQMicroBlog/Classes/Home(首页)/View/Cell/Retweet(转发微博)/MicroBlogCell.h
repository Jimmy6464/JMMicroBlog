//
//  MicroBlogCell.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetweetBlogView.h"
#import "OriginalBlogView.h"
/**
 *  转发微博cell
 */
@class Statues;

@interface MicroBlogCell : UITableViewCell

/**
 *  数据模型
 */
@property (nonatomic,strong) Statues *statues;

@property (nonatomic)CGFloat cellHeight;

+ (instancetype)microBlogCellWithTableView:(UITableView *)tableView;
@end
