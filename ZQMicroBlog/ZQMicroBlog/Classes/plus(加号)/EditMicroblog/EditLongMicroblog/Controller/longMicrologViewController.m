//
//  longMicrologViewController.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "longMicrologViewController.h"

@interface longMicrologViewController ()

@end

@implementation longMicrologViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnAction)];
    
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
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


@end
