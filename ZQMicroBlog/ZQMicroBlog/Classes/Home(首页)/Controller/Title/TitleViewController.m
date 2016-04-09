//
//  TitleViewController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "TitleViewController.h"

@interface TitleViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.bounces = NO;
    _data = @[@"好友圈",@"friend",@"sppdfds",@"好友圈",@"friend",@"sppdfds",@"好友圈",@"friend",@"sppdfds",@"好友圈",@"friend",@"sppdfds",@"好友圈",@"friend",@"sppdfds"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor orangeColor];
//        cell.backgroundView.backgroundColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_noarrow_background"]];
    
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popwindow_background"]];
//}
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_noarrow_background"]];
//    return indexPath;
//}
//- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
//{
//    NSLog(@"%s",__func__);
//}
@end
