//
//  FWBTalkController.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "FWBTalkController.h"
#import "AFHTTPRequestOperationManager.h"
#import "FWBMessageCell.h"
#import "FWBMessage.h"
#import "ReplyTableViewCell.h"
#import "TalkTableViewCell.h"
#import "DetailViewController.h"
#import "AccountTool.h"
#import "HttpTool.h"
#import "MJRefresh.h"
static UINavigationController *_naviC;
static UITabBarController *_tabb;
@interface FWBTalkController(){
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
@implementation FWBTalkController


-(void)didload{
    _dataArray=[NSMutableArray new];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"]= [AccountTool account].access_token;
    [HttpTool get:@"https://api.weibo.com/2/comments/to_me.json" parameters:params success:^(id responseObject) {
        NSDictionary *dic=[NSDictionary new];
        dic=responseObject;
        responArr=[dic objectForKey:@"comments"];
        [self performSelectorOnMainThread:@selector(getData:) withObject:responArr waitUntilDone:YES];
    } failure:^(NSError *error) {
         NSLog(@"error:%@",error);
    }];
    
}
-(void)viewDidLoad{
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(returnTo)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
    _rowHeightArr = [NSMutableArray new];
    [self didload];
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=150;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView addHeaderWithTarget:self action:@selector(endRef)];
    [_tableView reloadData];
    [_tableView headerBeginRefreshing];
   
}
-(void)endRef{
    [_tableView headerEndRefreshing];
}
-(NSString *)getPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths  objectAtIndex:0];
     NSString *filename=[path stringByAppendingPathComponent:@"wb.txt"];
//    NSLog(@"path:%@",filename);
    return filename;
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
//static NSInteger markCount=0;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"Cell";
    UITableViewCell *cell;
    NSInteger sectionNum=indexPath.section;
    for (int i=0; i<_dataArray.count; i++) {
        if (sectionNum==i) {
            if ([[_dataArray objectAtIndex:i]reply_comment]) {
                if (indexPath.row==0) {
                    FWBMessageCell  *cell=[[FWBMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    cell.messageBase=[_dataArray objectAtIndex:i];
                    return cell;
                }
                    else{
                    TalkTableViewCell *cell2=[[TalkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    cell2.messageBase=[_dataArray objectAtIndex:i];
                        return cell2;
                }
            }else{
                ReplyTableViewCell *cell=[[ReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                cell.messageBase=[_dataArray objectAtIndex:i];
                return cell;
            }
        }
    }
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cometext=[[_dataArray objectAtIndex:indexPath.section]text];
    
    NSDictionary *dic= [[_dataArray objectAtIndex:indexPath.section]reply_comment];
    NSDictionary *userDic=[dic objectForKey:@"user"];
    NSString *user=[NSString stringWithFormat:@"@%@%@",[userDic objectForKey:@"name"],[dic objectForKey:@"text"]];
    CGFloat h;
    CGFloat he;
    if (dic) {
        if (indexPath.row==0) {
         he=[self sizeWithString:cometext];
        return he+60;
        }else if (indexPath.row==1){
       h = [self sizeWithString:user]+100;
        return h;
        }
    }else{
        NSString *text=[[_dataArray objectAtIndex:indexPath.section]text];
      CGFloat  H=[self sizeWithString:text]+138;
        return H;
    }

    return 200;
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[TalkTableViewCell class]]) {
        TalkTableViewCell *cell=(TalkTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.btn.backgroundColor=[UIColor whiteColor];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[ReplyTableViewCell class]]) {
        ReplyTableViewCell *cell=(ReplyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[_dataArray objectAtIndex:section]reply_comment]) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma -mark 代理
-(void)pushMessage:(FWBMessage *)messageBase{
    [self pushToNextCBy:messageBase];
}

-(void)pushToNextCBy:(FWBMessage *)messageBase
{
    DetailViewController *dtvc=[DetailViewController new];
    self.delegate = dtvc;
    [self.delegate getMessage:messageBase];
    [self.navigationController pushViewController:dtvc animated:YES];
}
//自适应方法
- (CGFloat)sizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        [self pushToNextCBy:[_dataArray objectAtIndex:indexPath.section]];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[TalkTableViewCell class]]) {
        TalkTableViewCell *cell=(TalkTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.btn.backgroundColor=[UIColor whiteColor];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath]isKindOfClass:[ReplyTableViewCell class]]) {
        ReplyTableViewCell *cell=(ReplyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
         cell.btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    }
    cell.selected = NO;
}

-(void)returnTo
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"showTab" object:nil];
}
@end
