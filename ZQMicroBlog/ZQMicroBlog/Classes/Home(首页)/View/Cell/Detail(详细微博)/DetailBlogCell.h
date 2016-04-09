//
//  DetailBlogCell.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/5.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statues.h"
@interface DetailBlogCell : UITableViewCell
@property (nonatomic, strong) Statues *statues;
@property (nonatomic) CGFloat cellHeight;
+ (instancetype)cellWithTabView:(UITableView *)tableView;
@end
