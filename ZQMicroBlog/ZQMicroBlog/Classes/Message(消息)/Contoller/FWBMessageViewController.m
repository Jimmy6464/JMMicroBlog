//
//  FWBMessageViewController.m
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/2.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "FWBMessageViewController.h"
#import "FWBTalkController.h"
#import "ToMeViewController.h"
@interface FWBMessageViewController ()
{
    NSArray *messageIcon;
    NSArray *messageText;
}
@end

@implementation FWBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *chat = [[UIBarButtonItem alloc]initWithTitle:@"Chats" style:UIBarButtonItemStylePlain target:self action:@selector(chatsAction)];
    
    self.navigationItem.rightBarButtonItem = chat;
    
    UIBarButtonItem *findNew = [[UIBarButtonItem alloc]initWithTitle:@"发现群" style:UIBarButtonItemStylePlain target:self action:@selector(findNewAction)];
    
    self.navigationItem.leftBarButtonItem = findNew;
    
    messageIcon=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"messagescenter_at"],[UIImage imageNamed:@"messagescenter_comments"],[UIImage imageNamed:@"messagescenter_good"],[UIImage imageNamed:@"messagescenter_subscription"], nil];
    messageText =[[NSArray alloc]initWithObjects:@"@我的",@"评论",@"赞",@"订阅消息", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==1) {
        return messageIcon.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    }
    UIImageView *imageview=[UIImageView new];
    imageview.image=messageIcon[indexPath.row];
    imageview.frame=CGRectMake(13, 8, 54, 54);
    [cell addSubview:imageview];
    cell.textLabel.text=messageText[indexPath.row];
    cell.indentationLevel=2;
    cell.indentationWidth=35.0f;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
        ToMeViewController *talkC=[ToMeViewController new];
        [self.navigationController pushViewController:talkC animated:YES];
        
    }
    if (indexPath.row==1) {
        FWBTalkController *talkC=[FWBTalkController new];
        [self.navigationController pushViewController:talkC animated:YES];
    }
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
#pragma mark - 按钮事件
- (void)chatsAction
{
    NSLog(@"%s",__func__);
}
-(void)findNewAction{
 
}
@end
