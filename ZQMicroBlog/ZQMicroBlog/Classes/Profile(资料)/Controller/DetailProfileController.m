//
//  DetailProfileController.m
//  ZQMicroBlog
//
//  Created by ibokan on 15/12/2.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "DetailProfileController.h"
#import "ProfileDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "AccountTool.h"
#import "OrginalBlogCell.h"
#import "Statues.h"
#import "NSObject+MJKeyValue.h"
#import "HttpTool.h"
#import "StatuesResult.h"
#import "Common.h"
#import "BlogDetailsController.h"
#import "MJRefresh.h"
#import "PushTool.h"

@interface DetailProfileController ()<UIScrollViewDelegate,ProfileDelegate,UITableViewDataSource,UITableViewDelegate,BlogCellDelgate>
{
    UIScrollView *_scrollView;
    UITableView *_tableView;
    UIImageView *bgImagev;//背景图片
    UIToolbar *toolBar;
    UIImageView *orangImage;
    NSDictionary *discusDic;//评论微博
    
}
@property (nonatomic, strong) NSMutableArray *statues;
@end
static NSMutableArray *rowHeight;//行高
@implementation DetailProfileController
- (NSMutableArray *)statues
{
    if (_statues == nil) {
        NSMutableArray *array = [NSMutableArray new];
        _statues = array;
    }
    return _statues;
}
- (void)testLocalData
{
    int i = 0;
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:CurrentPath(@"prostatuses.plist")];
    for (NSDictionary *dic in dict[@"statuses"]) {
        Statues *staues = [Statues objectWithKeyValues:dic];
        [self.statues addObject:staues];
        i++;
        if (i == 19) {
            break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    rowHeight=[NSMutableArray new];
    UIView *nilView=[UIView new];
    [self testLocalData];
    [self getDataByWebWith];
    [self.view addSubview:nilView];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]];
    //导航栏透明
    for (UIView *view in [self.navigationController.navigationBar subviews]) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            view.alpha = 0;
        }
    }
    
    [self initScrollV];
    [self initToolBar];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    for (UIView *view in [self.navigationController.navigationBar subviews]) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            view.alpha = 1;
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    fale=YES;
}
//scrollview
-(void)initScrollV{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    bgImagev=[[UIImageView alloc]initWithFrame:CGRectMake(0,-100, self.view.frame.size.width, 400)];
    bgImagev.image=[UIImage imageNamed:@"page_cover_default_background"];

    [_scrollView addSubview:bgImagev];
    [self.view addSubview:_scrollView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,240, self.view.frame.size.width, self.view.frame.size.height-240)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.tag=10001;
    _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 800);
    [_scrollView addSubview:_tableView];
    
    UIImageView *proImageV=[[UIImageView alloc]initWithFrame:CGRectMake(150, 64, 79, 79)];
    UIImageView *strangerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    strangerImage.image=[UIImage imageNamed:@"findfriend_avatar_stranger"];
    proImageV.image=[UIImage imageWithData:_profileData.avatar_largeData];//头像

    proImageV.layer.cornerRadius=10;
    proImageV.layer.cornerRadius=39.0f;
    proImageV.layer.masksToBounds=YES;
    [proImageV addSubview:strangerImage];
    [_scrollView addSubview:proImageV];
    
    //用户名
    UILabel *userNameLabel=[[UILabel alloc]init];
    //关注
    UILabel *friendLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(proImageV.frame)+35, self.view.frame.size.width/2-14, 20)];
    //粉丝
    UILabel *followersLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+14,CGRectGetMaxY(proImageV.frame)+35 ,self.view.frame.size.width/2, 20)];
    //简介
    CGRect briefRect=[self sizeWithString:_profileData.Description andFont:[UIFont systemFontOfSize:13]];
    UILabel *briefLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, briefRect.size.width, 16)];
    briefLabel.center=CGPointMake(self.view.frame.size.width/2-10, CGRectGetMaxY(proImageV.frame)+72);
    briefLabel.text=_profileData.Description;
    briefLabel.textColor=[UIColor whiteColor];
    briefLabel.font=[UIFont systemFontOfSize:13];
    briefLabel.numberOfLines=1;
    UIImageView *panImageV=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(briefLabel.frame)+5, CGRectGetMinY(briefLabel.frame), 14,14)];
    panImageV.image=[UIImage imageNamed:@"userinfo_relationship_indicator_edit"];
    
    
    userNameLabel.text=_profileData.name;
    CGRect userNameRect=[self sizeWithString:userNameLabel.text andFont:[UIFont systemFontOfSize:17]];
    userNameLabel.frame=CGRectMake(0,CGRectGetMaxY(proImageV.frame)+15, userNameRect.size.width, 32);
    userNameLabel.center=CGPointMake(self.view.frame.size.width/2-20, CGRectGetMaxY(proImageV.frame)+22);
    userNameLabel.textColor=[UIColor whiteColor];
    userNameLabel.font=[UIFont systemFontOfSize:17];
    userNameLabel.textAlignment=NSTextAlignmentCenter;
    
    //性别
    UIImageView *genderV=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userNameLabel.frame)+9, CGRectGetMaxY(proImageV.frame)+16,14, 14)];
    if ([_profileData.gender isEqualToString:@"m"]) {
        genderV.image=[UIImage imageNamed:@"userinfo_icon_male"];
    }else{
        genderV.image=[UIImage imageNamed:@"userinfo_icon_female"];
    }
    
    friendLabel.text=[NSString stringWithFormat:@"关注 %ld",_profileData.friends_count];
    friendLabel.textColor=[UIColor whiteColor];
    friendLabel.textAlignment=NSTextAlignmentRight;
    friendLabel.font=[UIFont systemFontOfSize:12];
    
    followersLabel.text=[NSString stringWithFormat:@"粉丝 %ld",_profileData.followers_count];
    followersLabel.textColor=[UIColor whiteColor];
    followersLabel.textAlignment=NSTextAlignmentLeft;
    followersLabel.font=[UIFont systemFontOfSize:12];
    
    UIImageView *lineImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 12)];
    lineImage.image=[UIImage imageNamed:@"timeline_card_bottom_background"];
    lineImage.center=CGPointMake(self.view.frame.size.width/2, CGRectGetMaxY(proImageV.frame)+46);
    
    [_scrollView addSubview:userNameLabel];
    [_scrollView addSubview:friendLabel];
    [_scrollView addSubview:followersLabel];
    [_scrollView addSubview:genderV];
    [_scrollView addSubview:lineImage];
    [_scrollView addSubview:briefLabel];
    [_scrollView addSubview:panImageV];
}
-(void)initToolBar{
    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.tag=1024;
    toolBar.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    UIImageView *blackImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 42, self.view.frame.size.width, 2)];
    blackImage.image=[UIImage imageNamed:@"timeline_card_background_highlighted"];
    [toolBar addSubview:blackImage];
    
    UIBarButtonItem *nilBtn1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    orangImage=[[UIImageView alloc]initWithFrame:CGRectMake(95, 39, 46, 2)];
    orangImage.image=[UIImage imageNamed:@"radar_card_button_discount"];
    orangImage.tag=10002;
    [toolBar addSubview:orangImage];
    
    UIButton *hbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hbtn.frame=CGRectMake(0, 0, 60, 40);
    hbtn.tag=1000;
    [hbtn setTitle:@"主页" forState:UIControlStateNormal];
    [hbtn setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
    hbtn.selected=YES;
    [hbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [hbtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    hbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [hbtn addTarget:self action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    wbtn.frame=CGRectMake(0, 0, 60, 40);
    wbtn.tag=1001;
    [wbtn setTitle:@"微博" forState:UIControlStateNormal];
    [wbtn setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [wbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [wbtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    wbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [wbtn addTarget:self action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    pbtn.frame=CGRectMake(0, 0, 60, 40);
    pbtn.tag=1002;
    [pbtn setTitle:@"相册" forState:UIControlStateNormal];
    [pbtn setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [pbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [pbtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    pbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [pbtn addTarget:self action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *homeBtn=[[UIBarButtonItem alloc]initWithCustomView:hbtn];
    
    UIBarButtonItem *weboBtn=[[UIBarButtonItem alloc]initWithCustomView:wbtn];
    UIBarButtonItem *photoBtn=[[UIBarButtonItem alloc]initWithCustomView:pbtn];
    
    UIBarButtonItem *nilBtn2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items=@[nilBtn1,homeBtn,weboBtn,photoBtn,nilBtn2];
}
#pragma  -mark 按钮方法
-(void)homeBtnAction:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        orangImage.frame=CGRectMake(btn.frame.origin.x+8, 39, 46, 2);
    }];
    for (UIView *thebtn in [toolBar subviews]) {
        if([thebtn isKindOfClass:[UIButton class]]){
            UIButton *bbtn=(UIButton*)thebtn;
            if (bbtn.tag!=btn.tag) {
                bbtn.selected=NO;
            }
        }
    }
    btn.selected=YES;
    [btn setTintColor:[UIColor blackColor]];
    if (btn.tag==1000) {
        [_tableView removeFromSuperview];
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,240, self.view.frame.size.width, 700)];
        _tableView.tag=10001;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_scrollView addSubview:_tableView];
    }
    if (btn.tag==1001) {
        countNum=0;
        rowH=0;
        [_tableView removeFromSuperview];
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,240, self.view.frame.size.width, self.view.frame.size.height-240)];
        _tableView.tag=10002;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_scrollView addSubview:_tableView];
    }
    if (btn.tag==1002) {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -mark scrollview代理
static bool fale=YES;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-170) {
        scrollView.contentOffset=CGPointMake(0, -170);
    }
    if (scrollView.contentOffset.y>176) {
        //导航栏出现
        for (UIView *view in [self.navigationController.navigationBar subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                view.alpha=1;
            }
        }
        toolBar.frame=CGRectMake(0, 64, self.view.frame.size.width, 44);
        [self.view addSubview:toolBar];
        fale=NO;
    }
    //导航栏透明
        if(scrollView.contentOffset.y<176){
            fale=YES;
            for (UIView *view in [self.navigationController.navigationBar subviews]) {
                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                    view.alpha=0;
                }
            }
            for (UIView *view in self.view.subviews) {
                if (view.tag==1024) {
                    [view removeFromSuperview];
                    toolBar.frame=CGRectMake(0, 240, self.view.frame.size.width, 44);
                    [_scrollView addSubview:toolBar];
                }
            }
        }

    bgImagev.frame=CGRectMake(0, -100+scrollView.contentOffset.y*0.5, self.view.frame.size.width, 400);
}
#pragma -mark tableview代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrginalBlogCell"];
    }
    
    if (tableView.tag==10002) {
        if (indexPath.section==0) {
            cell.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
            if (fale) {
                toolBar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
                [cell addSubview:toolBar];
            }
             return cell;
        }
                Statues *st = self.statues[indexPath.row];
                if (st.retweeted_status) {
                    MicroBlogCell *mCell = [MicroBlogCell microBlogCellWithTableView:tableView];

                    mCell.statues = st;
                    [rowHeight addObject:[NSString stringWithFormat:@"%f",mCell.cellHeight]];
                    return mCell;
                }else {
                    OrginalBlogCell *cell = [OrginalBlogCell orginalBlogCellWithView:tableView];
                    cell.originalBlogV.delgate = self;
                    if (self.statues.count != 0) {
                        cell.statues = st;
                        [rowHeight addObject:[NSString stringWithFormat:@"%f",cell.cellHeight]];
                        
                    }
                    return cell;
                }
        

    }
    if (tableView.tag==10001) {
    if (indexPath.section==0) {
        cell.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        if (fale) {
            toolBar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
            [cell addSubview:toolBar];
        }
        return cell;
    }
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                UILabel *location=[[UILabel alloc]initWithFrame:CGRectMake(80, 6, 280, 30)];
                location.font=[UIFont systemFontOfSize:14];
                location.text=_profileData.location;
                cell.textLabel.text=@"所在地";
                cell.textLabel.font=[UIFont systemFontOfSize:14];
                cell.textLabel.textColor=[UIColor lightGrayColor];
                [cell addSubview:location];
            }else{
                UILabel *more=[[UILabel alloc]init];
                more.frame=CGRectMake(0, 0, 150, 30);
                more.center=CGPointMake(self.view.frame.size.width/2+30, 25);
                more.font=[UIFont systemFontOfSize:15];
                more.text=@"更多基本资料";
                more.textColor=[UIColor lightGrayColor];
                [cell addSubview:more];
            }
        }
        if (indexPath.section==2) {
            
        }
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==10001) {
        if (section==0) {
            return 1;
        }
    }
    if (tableView.tag==10002) {
        if (section==0) {
            return 1;
        }
        return _statues.count;
    }
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==10001) {
        return 3;
    }
    if (tableView.tag==10002) {
        return 2;
    }
    return _statues.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 11;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogDetailsController *blogDetails = [[BlogDetailsController alloc] init];
    [PushTool pushController:blogDetails byView:tableView withObject:@{StatusKey:self.statues[indexPath.row]}];
}
#pragma -mark计算tableview 总高度
static NSInteger countNum=0;
static  NSInteger  rowH=0;
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10001) {
        _tableView.frame=CGRectMake(0,240, self.view.frame.size.width, self.view.frame.size.height-240);
        _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 1000);
        return 44;
    }else{
        if (indexPath.section==1) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            if (cell) {
                countNum++;
                if ([cell.reuseIdentifier isEqualToString:@"OrginalBlogCell"]) {
                    OrginalBlogCell *cell1 = (OrginalBlogCell *) cell;
                    rowH +=cell1.cellHeight;
                    return cell1.cellHeight;
                }else {
                    MicroBlogCell *cell2 = (MicroBlogCell *) cell;
                    rowH +=cell2.cellHeight;
                    return cell2.cellHeight;
                }
            }
        }
        if (countNum==_statues.count) {
            [self performSelectorOnMainThread:@selector(changeFrame:) withObject:[NSString stringWithFormat:@"%ld",rowH] waitUntilDone:YES];
        }

        return 44;
    }
}
-(void)changeFrame:(NSString *)str{
    _tableView.frame=CGRectMake(0,240, self.view.frame.size.width,[str integerValue]+240);
    _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, [str integerValue]+300);
}

#pragma -mark 文本高度自适应
- (CGRect)sizeWithString:(NSString *)string andFont:(UIFont*)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(180, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect;
}
-(void)getProfileData:(ProfileData *)data{
    _profileData=data;
}
#pragma -mark 网络请求
-(void)getDataByWebWith
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
    params[@"access_token"]= [AccountTool account].access_token;
    params[@"uid"] = [AccountTool account].uid;
    [HttpTool get:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(id responseObject) {
        NSMutableArray *status = [NSMutableArray array];
        //添加新数据
        StatuesResult *result = [StatuesResult objectWithKeyValues:responseObject];
        for (NSDictionary *dict in responseObject[@"statuses"]) {
            Statues *staues = [Statues objectWithKeyValues:dict];
            [status addObject:staues];
        }
        [result.keyValues writeToFile:CurrentPath(@"prostatuses.plist") atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
#pragma -mark cell点击时间
- (void)contentClicked:(NSURL *)url{
    NSLog(@"");
}
@end
