//
//  HomeController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+SetUpBarButtonItem.h"

#import "BlogDetailsController.h"
#import "DetailProfileController.h"
#import "ContactViewController.h"

#import "MJRefresh.h"

#import "TitleButton.h"
#import "TitleView.h"
#import "TitleViewController.h"
#import "WebViewController.h"
#import "MicroBlogCell.h"
#import "OrginalBlogCell.h"
#import "DetailBlogCell.h"

#import "HttpTool.h"
#import "AccountTool.h"
#import "StatuesResult.h"
#import "Statues.h"
#import "StatusesTool.h"
#import "CommentTool.h"
#import "URLTool.h"
#import "PushTool.h"
@interface HomeController ()<TitleView,BlogCellDelgate>
@property (nonatomic, strong) TitleButton *titleButton;
@property (nonatomic, strong) TitleViewController *titleVC;
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) NSMutableArray *statues;
@end
static NSTimer *timer = nil;
@implementation HomeController
- (NSMutableArray *)statues
{
    if (_statues == nil) {
        NSMutableArray *array = [NSMutableArray new];
        _statues = array;
    }
    return _statues;
}
- (TitleView *)titleView
{
    if (_titleView == nil) {
        TitleView *title = [[TitleView alloc]initWithFrame:KeyWindow.bounds];
        title.backgroundView.backgroundColor = [UIColor clearColor];
        title.delegate  = self;
        _titleView = title;
    }
    return _titleView;
}
- (TitleViewController *)titleVC
{
    if (_titleVC == nil) {
        TitleViewController *tv = [TitleViewController new];
        _titleVC = tv;
    }
    return _titleVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置导航条
    [self setUpNaviItem];
    //2.添加刷新控件
    [self addReflashing];
    [self testLocalData];
    //3.进入微博开始刷新
    [self.tableView headerBeginRefreshing];

    
}
- (void)testLocalData
{
    int i = 0;
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:CurrentPath(@"statuses.plist")];
    for (NSDictionary *dic in dict[@"statuses"]) {
        Statues *staues = [Statues objectWithKeyValues:dic];
        [self.statues addObject:staues];
        i++;
        if (i == 19) {
            break;
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 设置用户名
- (void)getUserName
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"uid"] = [AccountTool account].uid;
    [HttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        Account *account = [AccountTool account];
        account.name = dic[@"name"];
        [AccountTool saveAccount:account];
        
        [self.titleButton setTitle:account.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 添加刷新控件
- (void)addReflashing
{
    [self.tableView addHeaderWithTarget:self action:@selector(loadMicroBlogData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreBlogData)];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statues.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Statues *st = self.statues[indexPath.row];

    if (st.retweeted_status) {
        MicroBlogCell *mCell = [MicroBlogCell microBlogCellWithTableView:tableView];
        mCell.statues = st;
        return mCell;
    }else {
        OrginalBlogCell *cell = [OrginalBlogCell orginalBlogCellWithView:tableView];
        cell.originalBlogV.delgate = self;
        if (self.statues.count != 0) {
            cell.statues = st;
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"OrginalBlogCell"]) {
        OrginalBlogCell *cell1 = (OrginalBlogCell *) cell;
        return cell1.cellHeight;
    }else {
        MicroBlogCell *cell2 = (MicroBlogCell *) cell;

        return cell2.cellHeight;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogDetailsController *blogDetails = [[BlogDetailsController alloc] init];
    [PushTool pushController:blogDetails byView:tableView withObject:@{StatusKey:self.statues[indexPath.row]}];
}

#pragma mark - 设置导航条
- (void)setUpNaviItem
{
    //好友
    UIBarButtonItem *friendattention = [UIBarButtonItem barButtonWithImage:@"navigationbar_friendattention" highligthedImage:@"navigationbar_friendattention_highlighted" selector:@selector(goToContacts:) target:self];
    
    //雷达
    UIBarButtonItem *radar = [UIBarButtonItem barButtonWithImage:@"navigationbar_icon_radar" highligthedImage:@"navigationbar_icon_radar_highlighted" selector:nil target:self];
    self.navigationItem.leftBarButtonItem = friendattention;
    self.navigationItem.rightBarButtonItem = radar;

    //标题
    TitleButton *titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    _titleButton = titleButton;
    NSString *name = [AccountTool account].name;
    if (name == nil) {
        [self getUserName];
    }else{
        [titleButton setTitle:name forState:UIControlStateNormal];
    }
}
- (void)goToContacts:(id)sender
{
    ContactViewController *contact = [ContactViewController new];

    [PushTool presentController:contact byView:sender withObject:nil];
}
#pragma mark - 按钮点击事件
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    CGSize size = self.navigationController.navigationBar.frame.size;
    CGFloat x = (size.width - 200) * 0.5;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 9;
    self.titleView.contentView = self.titleVC.view;

    [self.titleView showTitleViewInRect:CGRectMake(x, y, 200, 400)];
}
#pragma mark - 隐藏titleView
- (void)removeTitleView:(TitleView *)title
{
    self.titleButton.selected = NO;
    title = nil;
}
#pragma mark - 刷新微博数据
- (void)loadMicroBlogData
{
    id since_id = nil;
    Statues *sta ;
    if (self.statues.count) {
        sta = self.statues[0];
    }
    if (sta.idstr) {
        since_id = sta.idstr;
    }
    [StatusesTool loadNewBlodWithSinceID:since_id success:^(NSArray *status) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        [self.statues insertObjects:status atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self showNewBlogCount:status.count];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView headerEndRefreshing];
    }];
}
- (void)loadMoreBlogData
{
    id max_id = nil;
    Statues *sta ;
    if (self.statues.count) {
        sta = [self.statues lastObject];
    }
    max_id = sta.idstr ? @([sta.idstr longLongValue] - 1) : nil;
    [StatusesTool loadMoreBlodWithMaxID:max_id success:^(NSArray *status) {
        [self.statues addObjectsFromArray:status];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView footerEndRefreshing];
    }];

}
- (void)showNewBlogCount:(NSInteger)count
{
    if (count == 0) {
        return;
    }
    CGFloat lblH = 35;
    CGFloat lblW = self.view.bounds.size.width;
    CGFloat lblY = self.navigationController.navigationBar.bounds.size.height + 20;
    UILabel *showBlogsLBl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, lblW, lblH)];
    showBlogsLBl.text = [NSString stringWithFormat:@"有%ld条新微博",count];
    showBlogsLBl.textAlignment = NSTextAlignmentCenter;
    showBlogsLBl.textColor = [UIColor whiteColor];
    showBlogsLBl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background" ]];
    
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:showBlogsLBl belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        showBlogsLBl.transform = CGAffineTransformMakeTranslation(0, lblY);
    } completion:^(BOOL finished) {
        //延迟1秒
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            showBlogsLBl.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [showBlogsLBl removeFromSuperview];
        }];
        
    }];

    
}


#pragma mark - 代理事件
- (void)contentClicked:(NSURL *)url
{
    if ( ![NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]) {
        //跳转到user
        DetailProfileController *blog = [DetailProfileController new];
        [self.navigationController pushViewController:blog animated:YES];
    }else {
        
        WebViewController *web = [[WebViewController alloc]init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goToSearch" object:nil userInfo:@{@"url":url}];
        [self.navigationController pushViewController:web animated:YES];
    }

    
}
@end
