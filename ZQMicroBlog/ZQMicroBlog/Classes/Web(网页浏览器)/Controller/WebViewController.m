//
//  WebViewController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/12/3.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD+MJ.h"
@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation WebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"浏览器";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchOnInternet:) name:@"goToSearch" object:nil];
    }
    return self;
}
- (UIWebView *)webView
{
    if (_webView == nil) {
        UIWebView *wv = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:wv];
        _webView = wv;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
#pragma mark - 开始上网
- (void)searchOnInternet:(NSNotification *)ntf
{
    NSDictionary *dict = ntf.userInfo;
    NSURL *url = dict[@"goToSearch"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    self.webView.delegate = self;
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s",__func__);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"Loading......"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    NSLog(@"%@",error);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [MBProgressHUD hideHUD];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"goToSearch" object:nil];
}
@end
