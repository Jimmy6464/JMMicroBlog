//
//  OAuthController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/24.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "OAuthController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "RootTool.h"
@interface OAuthController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation OAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    //组合url
    NSString *str =[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=https://www.baidu.com",APPKey];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - webviewdelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    //获取requestToken
    if (range.length > 0) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        //换取accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    //获取accessToken
    [AccountTool accessTokenWithCode:code success:^(Account *account) {
        [AccountTool saveAccount:account];
        [RootTool chooseRootController:KeyWindow];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"Loading"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
