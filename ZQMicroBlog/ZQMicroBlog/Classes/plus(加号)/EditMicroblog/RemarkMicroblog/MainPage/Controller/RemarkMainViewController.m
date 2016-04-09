//
//  RemarkMainViewController.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "RemarkMainViewController.h"

@interface RemarkMainViewController ()

@end

@implementation RemarkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
