//
//  ToMeViewController.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "ToMeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "FWBMessage.h"
#import "ToMeTableViewCell.h"
#import "DiscussViewController.h"
#import "DetailViewController.h"
#import "TextTableViewController.h"
#import "AccountTool.h"
#import "HttpTool.h"
#import "MJRefresh.h"

@interface ToMeViewController ()<FWBMessageDelegate>
{
    NSString *accessToken;
    NSDictionary *responseDic;
    NSArray *responArr;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSMutableArray *_rowHeightArr;
    
    UIButton *_btn;
    UIView *view;
    UILabel *label1;
    
}
@end
static UINavigationController *_naviC;
static UITabBarController *_tabb;
@implementation ToMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self didload];
    responArr=[NSArray new];
    
//    UIImageView *btnimageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back_withtext_highlighted@3x.png"]];
//    btnimageV.frame=CGRectMake(0, 0, 20, 40);
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
////    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_withtext_highlighted@3x.png"] forState:UIControlStateNormal];
//    [btn addSubview:btnimageV];
//    btn.frame=CGRectMake(5, 10, 50, 40);
//    [btn setTitle:@"fdsfs" forState:UIControlStateNormal];
//    btn.titleLabel.tintColor=[UIColor blackColor];
//    [btn addTarget:self action:@selector(returnTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(returnTo)];
//    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=150;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
//    [_tableView reloadData];
    [_tableView addHeaderWithTarget:self action:@selector(endRef)];
    [_tableView headerBeginRefreshing];
    
    _naviC = self.navigationController;
    _tabb = self.tabBarController;

}
-(void)endRef
{
    [_tableView headerEndRefreshing];
}
-(void)didload{
    _dataArray=[NSMutableArray new];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"]=[AccountTool account].access_token;
    [HttpTool get:@"https://api.weibo.com/2/statuses/mentions.json" parameters:params success:^(id responseObject) {
        NSDictionary *dic=[NSDictionary new];
        dic=responseObject;
        responArr = [dic objectForKey:@"statuses"];
        [self performSelectorOnMainThread:@selector(getData:) withObject:responArr waitUntilDone:YES];

    } failure:^(NSError *error) {
         NSLog(@"error:%@",error);
    }];
}
- (void)getData:(NSArray *)arr
{     
    for (NSDictionary *dic in arr) {
        FWBMessage *fwb=[FWBMessage StutasWithDictionary:dic];
        [_dataArray addObject:fwb];
    }
    [_tableView reloadData];
    [_tableView headerEndRefreshing];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName =@"Cell";
    UITableViewCell *cell;
    NSInteger sectionNum=indexPath.section;
    for (int i=0; i<_dataArray.count; i++) {
        if (sectionNum==i){
            ToMeTableViewCell *cell=[[ToMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.messageBase=[_dataArray objectAtIndex:i];
            cell.delegate=self;
            return cell;
            
        }
    }
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic= [[_dataArray objectAtIndex:indexPath.section]retweeted_status];
    NSString *user=[dic objectForKey:@"text"];
    CGFloat h;
    if ([[_dataArray objectAtIndex:indexPath.section]retweeted_status ]==nil) {
        return h+60;
    }
    h = [self sizeWithString:user]+108;
    return h;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==0) {
        [self pushToTextTVC:[_dataArray objectAtIndex:indexPath.section]];
    }
    cell.selected = NO;
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[ToMeTableViewCell class]]) {
        ToMeTableViewCell *cell=(ToMeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    }
   
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[ToMeTableViewCell class]]) {
        ToMeTableViewCell *cell=(ToMeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)sizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size.height;
}

#pragma -mark pushMessage代理
-(void)pushMessage:(FWBMessage *)messageBase{
    [self pushToNextCBy:messageBase];
}
-(void)pushToNextCBy:(FWBMessage *)messageBase
{
    DetailViewController *dtvc=[DetailViewController new];
    self.delegate=dtvc;
    [self.delegate getMessage:messageBase];
    [self.navigationController pushViewController:dtvc animated:YES];
}
-(void)pushToTextTVC:(FWBMessage *)messageBase
{
    TextTableViewController *dtvc=[TextTableViewController new];
    self.delegate=dtvc;
    [self.delegate getMessage:messageBase];
    [self.navigationController pushViewController:dtvc animated:YES];
}
-(void)returnTo
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
