//
//  TextTableViewController.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/30.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "TextTableViewController.h"
#import "TextTableViewCell.h"
#import "FWBMessage.h"
#import "TextToolBar.h"

#define Height 667
#define Width 375
#define Thex 30
#define They 10
#define  Theweight 19
#define Theheight 19
#define Weight 375

@interface TextTableViewController ()
{
    FWBMessage *_messageBase;
    UITableView *_tableView;
}
@property(strong,nonatomic)UIToolbar *itemToolbar;
@end
static UINavigationController *_naviC;
static UITabBarController *_tabb;
@implementation TextTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight=1000;
    [self performSelector:@selector(getMessage:) withObject:nil afterDelay:YES];
    [_tableView reloadData];
    
    _naviC = self.navigationController;
    _tabb = self.tabBarController;
    
    TextToolBar *toolBar=[[TextToolBar alloc]initWithFrame:CGRectMake(0, Height-40, Width, 40)];
    [self.view addSubview:toolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextTableViewCell *cell;
    if (!cell) {
        cell=[[TextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.messageBase=_messageBase;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getRowH:_messageBase];
}
-(void)getMessage:(FWBMessage *)messageBase{
    _messageBase=messageBase;
}

-(CGFloat)getRowH:(FWBMessage *)messageBase{
    NSDictionary *_retweeted_status= messageBase.retweeted_status;
    NSDictionary *statusDic=messageBase.status;
    float imagesizeh=0;
    CGFloat h=0;
    CGFloat textH=[self viewsizeWithString:[statusDic objectForKey:@"text"]];
    if (_retweeted_status) {
        NSString *imagepath=[_retweeted_status objectForKey:@"original_pic"];
        NSURL *imageurl=[NSURL URLWithString:imagepath];
        NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
        NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
        UIImage *theimage=[UIImage imageWithData:data2];
        float scaNum=self.view.frame.size.width/theimage.size.width;
        imagesizeh=theimage.size.height*scaNum;
        
        NSDictionary *userDic=[_retweeted_status objectForKey:@"user"];
        NSString *textString=[NSString stringWithFormat:@"@%@%@",[userDic objectForKey:@"name"],[_retweeted_status objectForKeyedSubscript:@"text"]];
         h=[self viewsizeWithString:textString]+20;
    }
    
    if ([statusDic objectForKey:@"original_pic"]) {
        NSString *imagepath=[statusDic objectForKey:@"original_pic"];
        NSURL *imageurl=[NSURL URLWithString:imagepath];
        NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
        NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
        UIImage *theimage=[UIImage imageWithData:data2];
        float scaNum=self.view.frame.size.width/theimage.size.width;
        imagesizeh=theimage.size.height*scaNum+56;
    }
    
    return imagesizeh+h+100+textH;
}
- (CGFloat)viewsizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size.height;
}

@end
