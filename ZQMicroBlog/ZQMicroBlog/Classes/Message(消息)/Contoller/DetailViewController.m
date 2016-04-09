//
//  DetailViewController.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/27.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "FWBMessage.h"

@interface DetailViewController ()
{
    FWBMessage *_messageBase;
    UITableView *_tableView;
}
@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight=1000;
    [self performSelector:@selector(getMessage:) withObject:nil afterDelay:YES];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell;
    if (!cell) {
        cell=[[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
    if (_retweeted_status) {
        NSString *imagepath=[_retweeted_status objectForKey:@"original_pic"];
        NSURL *imageurl=[NSURL URLWithString:imagepath];
        NSURLRequest *request2=[[NSURLRequest alloc]initWithURL:imageurl];
        NSData *data2=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
        UIImage *theimage=[UIImage imageWithData:data2];
        float scaNum=self.view.frame.size.width/theimage.size.width;
         imagesizeh=theimage.size.height*scaNum;
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
    CGFloat h=[self viewsizeWithString:[_retweeted_status objectForKeyedSubscript:@"text"]];
    return imagesizeh+h+68;
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
