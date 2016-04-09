//
//  OrginalBlogCell.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "OriginalBlogView.h"
/**
 *  原创微博cell
 */
@class Statues;
@interface OrginalBlogCell : UITableViewCell
/**
 *  原创微博
 */
@property (strong, nonatomic) OriginalBlogView *originalBlogV;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, strong) Statues *statues;

+ (OrginalBlogCell *) orginalBlogCellWithView:(UITableView *)tableView;
@end
