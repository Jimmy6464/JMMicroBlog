//
//  DiscussViewController.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/27.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DiscussViewController.h"
#import "FWBMessage.h"
@interface DiscussViewController ()
{
    FWBMessage *_messageBase;
}
@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushMessage:(FWBMessage *)messageBase{
    _messageBase=messageBase;
}

@end
