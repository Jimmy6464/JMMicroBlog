//
//  ProfileController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ProfileController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ProfileCellTableViewCell.h"
#import "DetailProfileController.h"
#import "ProfileDelegate.h"
#import "AccountTool.h"
#import "UserTool.h"
#import "MJRefresh.h"
#define Width KeyWindow.bounds.size.width
#define Height KeyWindow.bounds.size.height
#define UID [AccountTool account].uid

@interface ProfileController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cellArr1;
    NSArray *cellArr2;
    NSArray *cellArr3;
    NSArray *detailArr3;
    NSArray *cellArr4;
    NSArray *cellArr5;
    NSDictionary *btnDic;
    NSArray *btnDidKey;
    
    UITableView *_tableView;
    UIScrollView *_scrollView;
    
    NSMutableArray *_dataArray;
}
@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    [self getDataByWeb];
    [self initData];
    [self subUI];
    
}

//创建UI
-(void)subUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    _scrollView.contentSize=CGSizeMake(Width, 656);
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.bounces=NO;
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0 , Width, 640) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    [_scrollView addSubview:_tableView];
    [_tableView addHeaderWithTarget:self action:nil];
    [_tableView headerBeginRefreshing];
    [self.view addSubview:_scrollView];
 
}
-(void)initData{
    cellArr1=[[NSArray alloc]initWithObjects:@"新的好友",@"微博等级", nil];
    
    cellArr2=[[NSArray alloc]init];
    cellArr2=@[@"我的相册",@"我的点评",@"我的赞"];
    
    cellArr3=[[NSArray alloc]init];
    cellArr3=@[@"微博会员",@"微博运动",@"微博支付"];
    detailArr3=[NSArray new];
    detailArr3=@[@"卡片背景、送流量",@"步数、卡路里、跑步轨迹",@"积分赢小米4"];
    
    cellArr4=[NSArray new];
    cellArr4=@[@"草稿箱"];
    
    cellArr5=[NSArray new];
    cellArr5=@[@"更多"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ProfileCellTableViewCell *cell=[[ProfileCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            if (_dataArray.count!=0) {
                cell.profileData=[_dataArray objectAtIndex:0];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }if (indexPath.row==1) {
            if (_dataArray.count!=0) {
                for (int i=0; i<3; i++) {
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(i*Width/3, 0, Width/3,55);
                    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, Width/3, 55/2)];
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.font=[UIFont systemFontOfSize:14];
                    label1.text=[btnDic objectForKey:btnDidKey[i]];
                    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)-7, Width/3, 55/2)];
                    label2.text=btnDidKey[i];
                    label2.textAlignment=NSTextAlignmentCenter;
                    label2.font=[UIFont systemFontOfSize:14];
                    [btn addSubview:label1];
                    [btn addSubview:label2];
                    [cell addSubview:btn];
                    [btn addTarget:self action:@selector(adbtnAction:) forControlEvents:UIControlEventTouchDown];
                    [btn addTarget:self action:@selector(adbtnActionT:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        return cell;
    }else if (indexPath.section==1)
    {
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr1[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
    }else if (indexPath.section==2)
    {
        cell.textLabel.text=cellArr2[indexPath.row];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(95, 10, 200, 25)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor lightGrayColor];
        [cell addSubview:label];
    }else if(indexPath.section==3){
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr3[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(130,8.9, 200, 25)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor lightGrayColor];
        label.text=detailArr3[indexPath.row];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
        [cell addSubview:label];
    }else if (indexPath.section==4)
    {
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr4[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
    }else{
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr5[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(95,9, 200, 25)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor lightGrayColor];
        label.text=detailArr3[indexPath.row];
        label.text=@"数据中心、收藏、等级";
        [cell addSubview:label];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }
    else if (section==1) {
        return cellArr1.count;
    }else if (section==2)
    {
        return cellArr2.count;
    }else if(section==3)
    {
        return cellArr3.count;
    }else if (section==4){
        return cellArr4.count;
    }else{
        return cellArr5.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 90;
        }else{
            return 55;
        }
        }
        return 43;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selected=NO;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            DetailProfileController *dpController=[[DetailProfileController alloc]init];
            self.delegate =dpController;
            [self.navigationController pushViewController:dpController animated:YES];
            [self.delegate getProfileData:[_dataArray objectAtIndex:0]];
        }
    }
}

-(void)getDataByWeb{
    
    _dataArray=[NSMutableArray new];
    [UserTool userStatus:^(NSDictionary *dic) {
        [self performSelectorOnMainThread:@selector(getData:) withObject:dic waitUntilDone:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)getData:(NSDictionary *)dic
{
    ProfileData *fwb=[ProfileData StutasWithDictionary:dic];
    [_dataArray addObject:fwb];
    [_tableView headerEndRefreshing];
    btnDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%ld",fwb.statuses_count],[NSString stringWithFormat:@"%ld",fwb.friends_count],[NSString stringWithFormat:@"%ld",fwb.followers_count]] forKeys:@[@"微博",@"关注",@"粉丝"]];
    btnDidKey=[[NSArray alloc]init];
    btnDidKey=@[@"微博",@"关注",@"粉丝"];
    [_tableView reloadData];
}
-(void)adbtnAction:(UIButton *)btn{
        [btn setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
}
-(void)adbtnActionT:(UIButton *)btn{
    [btn setBackgroundColor:[UIColor whiteColor]];
}
@end
