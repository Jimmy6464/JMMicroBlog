//
//  PhotoViewController.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "TitleButton.h"
#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnAction)];
    
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    TitleButton *titleBtn = [[TitleButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleBtn setTitle:@"相机胶卷" forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleBtn ;
    
    // Do any additional setup after loading the view.
}

-(void)cancelBtnAction
{
    [self.navigationController dismissViewControllerAnimated:self completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
