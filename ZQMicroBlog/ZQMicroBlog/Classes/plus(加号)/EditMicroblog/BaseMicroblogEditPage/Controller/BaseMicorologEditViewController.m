//
//  BaseMicorologEditViewController.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "HttpTool.h"
#import "AccountTool.h"
#import "UserNavigationTitleLabel.h"
#import "FinishButton.h"
#import "ContactViewController.h"
#import "BaseMicorologEditViewController.h"

@interface BaseMicorologEditViewController ()
{
    UITextView *_textView;
    NSMutableArray *_sendTextMarr;
    CGFloat keybarodH;
    FinishButton *_sendBtn;
    SelfKeyBroad *_keyBroadView;
    UILabel *_lbl;
    NSString *_titleName;
}
@end

@implementation BaseMicorologEditViewController
#define  screenH  [UIScreen mainScreen].bounds.size.height
#define  screenW  [UIScreen mainScreen].bounds.size.width
-(instancetype)initWithTitleName:(NSString *)titleName
{
    if (self = [super init]) {
        [self initTitleWithTitleName:titleName];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self setUpUI];
    [_textView becomeFirstResponder];
    
    // Do any additional setup after loading the view.
}
#pragma mark - 设置子控件
- (void)setUpUI
{
    [self initNaviItems];
    [self initTextView];
    [self initSelfKB];
}
-(void)initNaviItems
{
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnAction)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    _sendBtn = [[FinishButton alloc]init];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendMicrolog) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_sendBtn];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    [_sendBtn setSelfEnabled:NO];
}
-(void)initTitleWithTitleName:(NSString *)titleName
{
    _titleName = titleName;
    UserNavigationTitleLabel *title = [[UserNavigationTitleLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    title.titleLabel.text = titleName;
    //此处需要获取当前用户名
    title.userNameLabel.text = [AccountTool account].name;
    
    self.navigationItem.titleView = title;
}
-(void)initTextView
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, screenW , screenH )];
    _textView.delegate = self;
    _textView.scrollEnabled = NO;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:20];
    _sendTextMarr = [[NSMutableArray alloc]init];
    [self addGestuerToTextView];
    [self.view addSubview:_textView];
    
    _lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 15 , 100, 15)];
    _lbl.text = @"分享新鲜事...";
    _lbl.font = [UIFont systemFontOfSize:20.0];
    _lbl.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_lbl];
}
-(void)addGestuerToTextView
{
    UISwipeGestureRecognizer *sw = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swAction)];
    sw.direction = UISwipeGestureRecognizerDirectionDown;
    [_textView addGestureRecognizer:sw];
    
    UISwipeGestureRecognizer *sw2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swAction)];
    sw.direction = UISwipeGestureRecognizerDirectionUp;
    [_textView addGestureRecognizer:sw2];
    
}
-(void)initSelfKB
{
    _keyBroadView = [[SelfKeyBroad alloc]initWithFrame:CGRectMake(0,200, 375, 667 - 200 )];
    _keyBroadView.owner = _textView;
    _keyBroadView.kbDelegate = self;
    [self.view addSubview:_keyBroadView];
}
#pragma mark-导航栏按钮触发的方法
-(void)sendMicrolog
{
    [_sendBtn setSelfEnabled:NO];
    [_textView resignFirstResponder];
    if ([_titleName isEqualToString:@"发微博"]) {
        [self sendBaseMicrolog];
    }
    else if([_titleName isEqualToString:@"发评论"])
    {
        [self sendComment];
    }
    else if([_titleName isEqualToString:@"发回复"])
    {
        [self sendReply];
    }
    else if([_titleName isEqualToString:@"转发微博"])
    {
        [self sendRepost];
    }
}

-(void)cancelBtnAction
{
    [_textView resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:self completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-发送微博
-(void)sendBaseMicrolog
{
    NSString *sendStr = [[[TextAndImageTool alloc]init] getStrByAttributeStr:_textView.attributedText];
    
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[AccountTool account].access_token,@"access_token",sendStr,@"status", nil];
    [self sendMicrologByURL:url andSelfDataDic:dic];
}
-(void)sendComment
{
    NSString *sendStr = [[[TextAndImageTool alloc]init] getStrByAttributeStr:_textView.attributedText];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[AccountTool account].access_token,@"access_token",sendStr,@"comment",[NSNumber numberWithInteger:_microlongId],@"id", nil];
    NSString *url = @"https://api.weibo.com/2/comments/create.json";
    [self sendMicrologByURL:url andSelfDataDic:dic];
}
-(void)sendReply
{
    NSString *sendStr = [[[TextAndImageTool alloc]init] getStrByAttributeStr:_textView.attributedText];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[AccountTool account].access_token,@"access_token",sendStr,@"comment",[NSNumber numberWithInteger:_microlongId],@"id",[NSNumber numberWithInteger:_CId],@"cid", nil];
    NSString *url = @"https://api.weibo.com/2/comments/reply.json";
    [self sendMicrologByURL:url andSelfDataDic:dic];
}
-(void)sendRepost
{
    NSString *sendStr = [[[TextAndImageTool alloc]init] getStrByAttributeStr:_textView.attributedText];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[AccountTool account].access_token,@"access_token",sendStr,@"status",[NSNumber numberWithInteger:_microlongId],@"id", nil];
    NSString *url = @"https://api.weibo.com/2/statuses/repost.json";
    [self sendMicrologByURL:url andSelfDataDic:dic];
}
-(void)sendMicrologByURL:(NSString *)url andSelfDataDic:(NSDictionary *)dataDic
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithDictionary:dataDic];
    

    [HttpTool post:url parameters:parameters success:^(id responseObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:@"发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"发送失败，请检查网络配置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_textView becomeFirstResponder];
        [_sendBtn setSelfEnabled:YES];
    }];
}
#pragma mark-键盘回收时和键盘出现时触发的方法
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keybarodH = keyboardRect.size.height;
    _keyBroadView.keybarodH = keybarodH;
    [_keyBroadView updateSelfHighWithHigh:keybarodH];
}
-(void)swAction
{
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
        [_keyBroadView updateSelfHighWithHigh:0];
    }
    else
    {
        [_textView becomeFirstResponder];
    }
}
#pragma mark-自定义键盘代理方法
-(void)emoBtnAction:(NSString *)str
{
     NSAttributedString *imageStr = [[[TextAndImageTool alloc]init] getAttributeStringByStr:str andFontSize:20];
    if (imageStr.length == 1) {
        [_sendTextMarr addObject:str];
    }
    NSInteger location =_textView.selectedRange.location;
    NSMutableAttributedString *mts = [[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [mts insertAttributedString:imageStr atIndex:_textView.selectedRange.location];
    
    _textView.attributedText = mts ;
    _textView.font = [UIFont systemFontOfSize:20];
    [self changeStatic];
    _textView.selectedRange = NSMakeRange(location+1, 0);
}
-(void)presentToMentionController
{

    NSLog(@"%s",__func__);
    ContactViewController *contact = [ContactViewController new];
    [self presentViewController:contact animated:YES completion:nil];
}
-(void)presentToPhotoViewController
{
    
}
-(void)presentToTrendViewController
{
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    [self changeStatic];
    
}


-(void)changeStatic
{
    if ([_textView.attributedText.string isEqualToString:@""]) {
        _lbl.hidden = NO;
        [_sendBtn setSelfEnabled:NO];
    }
    else
    {
        _lbl.hidden = YES;
        [_sendBtn setSelfEnabled:YES];
    }
}
@end
