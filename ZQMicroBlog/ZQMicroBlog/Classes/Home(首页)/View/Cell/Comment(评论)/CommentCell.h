//
//  CommentCell.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@interface CommentCell : UITableViewCell
@property (nonatomic, strong) Comment *comment;
@property (nonatomic) CGFloat cellH;
+ (instancetype)cellWithTableview:(UITableView *)tableView;
@end
