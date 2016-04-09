//
//  BlogDetailsController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/28.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "BlogDetailsController.h"
#import "MicroBlogCell.h"
#import "DetailBlogCell.h"
#import "OrginalBlogCell.h"
#import "ReflashCell.h"
#import "CommentCell.h"
#import "ToolDock.h"
#import "Statues.h"

#import "CommentTool.h"
#import "AccountTool.h"
#import "Comment.h"
#import "MJRefresh.h"
@interface BlogDetailsController ()<UITableViewDataSource,UITableViewDelegate,ToolDockDelegate>
/**
 *  工具条
 */
@property (strong, nonatomic)ToolDock *toolView;
/**
 *  显示内容
 */
@property (strong, nonatomic)UITableView *myTableView;
@property (strong, nonatomic)ToolDock *smallTool;
/**
 *  数据字典
 */
@property (strong, nonatomic) Statues *status;
@property (strong, nonatomic) NSMutableArray *comments;
@end
//通知是否移除
BOOL flag ;
@implementation BlogDetailsController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"微博详情";
        self.view.backgroundColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStatus:) name:StatusKey object:nil];
        flag = YES;
    }
    return self;
}

- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        CGRect rect = self.view.bounds;
        UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 44) style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _myTableView = tab;
    }
    return _myTableView;
}
- (NSMutableArray *)comments
{
    if (_comments == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _comments = array;
    }
    return _comments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    [self setUpReflash];
}
- (void)setUpReflash
{
    [self.myTableView addFooterWithTarget:self action:@selector(loadMoreComments)];
}
#pragma mark - 获取微博数据
- (void)getStatus:(NSNotification *)ntf
{
    NSDictionary *dict = ntf.userInfo;
    self.status =  dict[StatusKey];

    [self loadNewComments];
//    if (dict[@"index"]) {
//        NSNumber *value = dict[@"index"];
//        [self btnPressedAtIndex:value.integerValue];
//    }
    _smallTool.status = self.status;
    _toolView.status = self.status;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置子控件
- (void)setUpSubviews
{
    //主tableview
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    //工具条
    ToolDock *toolV = [[ToolDock alloc]init];
    toolV.frame = CGRectMake(0, KeyWindow.bounds.size.height - 44, KeyWindow.bounds.size.width, 44);
    toolV.tag = 1478;
    [self.view addSubview:toolV];
    _toolView = toolV;
    
    
    
    //sectionTitle
    ToolDock *tool = [[ToolDock alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    tool.delegate = self;
    
    tool.userInteractionEnabled = YES;
    UIImageView *bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"radar_card_button_discount"]];
    bottom.tag = 11111;
    bottom.frame = CGRectMake(tool.bounds.size.width/3, 35, tool.bounds.size.width/3, 2);
    [tool addSubview:bottom];
    _smallTool = tool;
    
}
#pragma mark - 更新评论
- (void)loadNewComments
{
    //test评论数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"id"] = @(_status.id);
    if (self.comments.count) {
        Comment *comment = [self.comments firstObject];
        params[@"max_id"] = @([comment.idstr intValue] - 1);
    }
    
    [CommentTool loadNewCommentWithParams:params success:^(NSArray *comments) {
        if (comments.count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenReflash" object:nil];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, comments.count)];
        [self.comments insertObjects:comments atIndexes:indexSet];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenReflash" object:nil];
    }];
}
- (void)loadMoreComments
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"id"] = @(_status.id);
    if (self.comments.count) {
        Comment *comment = [self.comments lastObject];
        params[@"max_id"] = @([comment.idstr longLongValue] - 1);
    }
    [CommentTool loadNewCommentWithParams:params success:^(NSArray *comments) {
        if (comments.count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenReflash" object:nil];
        }
        [self.comments addObjectsFromArray:comments];
        [self.myTableView reloadData];
        [self.myTableView footerEndRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenReflash" object:nil];
        [self.myTableView footerEndRefreshing];
    }];
    
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.comments.count) {
        if (section == 0) {
            return 1;
        }
        return self.comments.count;
    }else {
        if (section == 0) {
            return 1;
        }
        return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Statues *st = self.status;
        DetailBlogCell *cell = [DetailBlogCell cellWithTabView:tableView];
        cell.statues = st ;
        return cell;
    }else {
        if (self.comments.count) {
            CommentCell *cell = [CommentCell cellWithTableview:tableView];
            Comment *comment = self.comments[indexPath.row];
            cell.comment = comment;
            return cell;
        }else {
            ReflashCell *reflasC = [ReflashCell cellWithTableView:tableView];
            return reflasC;
        }
        
    }
}
//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        DetailBlogCell *bCell = (DetailBlogCell *)cell;
        return bCell.cellHeight;
    }
    if (self.comments.count) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        CommentCell *comm = (CommentCell *)cell;
        return comm.cellH;
    }else {
        return 44;
    }
    
}
//设置section的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return self.smallTool;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 33;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 33;
    }
    return 0;
}
#pragma mark - smallTool的按钮事件
- (void)btnPressedAtIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_smallTool viewWithTag:index];
    UIImageView *bottom = (UIImageView *)[_smallTool viewWithTag:11111];
    [UIView animateWithDuration:0.3 animations:^{
        bottom.frame=CGRectMake(btn.frame.origin.x, 35, self.smallTool.bounds.size.width/3, 2);
    }];
    [self loadNewComments];
}
#pragma mark - 移除监听者
- (void)viewDidAppear:(BOOL)animated
{
    if (flag) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:StatusKey object:nil];
        flag = !flag;
    }
}
@end
