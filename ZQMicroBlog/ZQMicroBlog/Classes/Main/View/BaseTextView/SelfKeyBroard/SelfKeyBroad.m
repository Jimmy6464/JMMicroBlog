//
//  SelfKeyBroad.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//
#import "EmoticonView.h"
#import "SelfKeyBroad.h"
@interface SelfKeyBroad()
{
    UIButton *_photoBtn;//跳转到加载图片控制器的按钮
    UIButton *_mentionBtn;//@按钮
    UIButton *_trendBtn;//点评电影按钮
    UIButton *_emoticonBtn;//表情键盘按钮
    UIButton *_addBtn;//添加项按钮
    UIButton *_editTextBtn;//文本编辑按钮，用于控制显示或回收键盘
    CGFloat w;
    UIView *_toolBar;
    UIView *_inputView;//工具栏下面用于放置
    UIButton *_shareAreaBtn;//工具栏上分享范围跳转按钮
    UIButton *_locationBtn;//工具栏上位置控制器跳转按钮
    EmoticonView *_emoticonView;//表情视图
}
@end
@implementation SelfKeyBroad
#define  screenH  [UIScreen mainScreen].bounds.size.height
#define  screenW  [UIScreen mainScreen].bounds.size.width
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        w = screenH * 44.0 / 667.0 ;
        //增加监听，当键盘出现或改变时收出消息
        [self initShareAreaBtn];
        [self initLocationBtn];
        [self initToolBar];
        [self initInputView];
        [self initEditTextBtn];
        
        CGFloat y = screenH - _toolBar.frame.size.height - _locationBtn.frame.size.height;
        CGFloat h = _toolBar.frame.size.height + _locationBtn.frame.size.height + _inputView.frame.size.height;
        self.frame = CGRectMake(0, y, screenW , h);
    }
    return self;
}
#pragma mark-位置按钮与分享范围按钮
-(void)initShareAreaBtn
{
    _shareAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat h = 25 / 667 * screenH ;
    _shareAreaBtn.frame = CGRectMake(0 , 0 , 100, h);
}
-(void)initLocationBtn
{
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat h = 25 / 667 * screenH ;
    _locationBtn.frame = CGRectMake(0 , 0 , 100, h);
}
#pragma mark-初始化工具栏及其上面的按钮
-(void)initToolBar
{
    _toolBar = [[UIView alloc]initWithFrame:CGRectMake(-1, _locationBtn.frame.size.height, screenW+2 , screenH * 44 / 667 )];
    _toolBar.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    w = _toolBar.frame.size.height;
    [self initPhotoBtn];
    [self initTrendBtn];
    [self initMentionbutton];
    [self initEmoticonBtn];
    [self initAddBtn];
    [self addSubview:_toolBar];
}
-(void)initPhotoBtn
{
    _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoBtn.frame = CGRectMake(0, 0, screenW / 5 , w);
    [_photoBtn setImage:[UIImage imageNamed:@"compose_toolbar_picture"] forState:UIControlStateNormal];
    [_photoBtn setImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] forState:UIControlStateHighlighted];
    [_photoBtn addTarget:self action:@selector(photoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_photoBtn];
    
}
-(void)photoBtnAction
{
    [self.kbDelegate presentToPhotoViewController];
}
-(void)initMentionbutton
{
    _mentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mentionBtn.frame = CGRectMake(screenW / 5 * 1, 0, screenW / 5 , w);
    [_mentionBtn setImage:[UIImage imageNamed:@"compose_mentionbutton_background"] forState:UIControlStateNormal];
    [_mentionBtn setImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [_mentionBtn addTarget:self action:@selector(mentionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_mentionBtn];
}
-(void)mentionBtnAction
{
    [self.kbDelegate presentToMentionController];
}
-(void)initTrendBtn
{
    _trendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _trendBtn.frame = CGRectMake(screenW / 5 * 2, 0, screenW / 5 , w);
    [_trendBtn setImage:[UIImage imageNamed:@"compose_trendbutton_background"] forState:UIControlStateNormal];
    [_trendBtn setImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [_trendBtn addTarget:self action:@selector(trendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_trendBtn];
}
-(void)trendBtnAction
{
    [self.kbDelegate presentToTrendViewController];
}
-(void)initEmoticonBtn
{
    _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emoticonBtn.frame = CGRectMake(screenW / 5 * 3, 0, screenW / 5 , w);
    [_emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [_emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [_emoticonBtn addTarget:self action:@selector(emoticonBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_emoticonBtn];
}
-(void)emoticonBtnAction
{
    [self emoticonViewShow];
    [_owner resignFirstResponder];
    _editTextBtn.frame = CGRectMake(screenW / 5 * 3 , _toolBar.frame.origin.y , _editTextBtn.frame.size.width, _editTextBtn.frame.size.height);
    _editTextBtn.hidden = NO;
    _emoticonBtn.hidden = YES;
    _addBtn.hidden = NO;
}
-(void)emoticonViewShow
{
    [UIView animateWithDuration:0.2 animations:^{
        [self updateSelfHighWithHigh:_emoticonView.frame.size.height];
        _emoticonView.frame = CGRectMake(0, 0, _emoticonView.frame.size.width, _emoticonView.frame.size.height);
    } completion:nil];
}
-(void)emoticonViewHide
{
    [UIView animateWithDuration:0.2 animations:^{
        _emoticonView.frame = CGRectMake(0, _emoticonView.frame.size.height, _emoticonView.frame.size.width, _emoticonView.frame.size.height);
    } completion:nil];

}
-(void)initAddBtn
{
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(screenW / 5 * 4 , 0, screenW / 5 , w);
    [_addBtn setImage:[UIImage imageNamed:@"message_add_background"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"message_add_background_highlighted"] forState:UIControlStateHighlighted];
    [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_addBtn];
}
-(void)addBtnAction
{
    _editTextBtn.frame = CGRectMake(screenW / 5 * 4 , _toolBar.frame.origin.y , screenW / 5 , w);
    [_owner resignFirstResponder];
    [self updateSelfHighWithHigh:_emoticonView.frame.size.height];
    [self emoticonViewHide];
    _editTextBtn.hidden = NO;
    _emoticonBtn.hidden = NO;
    _addBtn.hidden = YES ;
}
-(void)initEditTextBtn
{
    _editTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editTextBtn.frame = CGRectMake(0, _toolBar.frame.origin.y , screenW / 5 , w);
    [_editTextBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
    [_editTextBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [_editTextBtn addTarget:self action:@selector(editTextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editTextBtn];
    _editTextBtn.hidden = YES;
}
-(void)editTextBtnAction
{
    
    [_owner becomeFirstResponder];
//    UITextView *textView = (UITextView *)_owner;
    
    [UIView animateWithDuration:0.2 animations:^{
        _emoticonView.frame = CGRectMake(0, _emoticonView.frame.size.height, _emoticonView.frame.size.width, _emoticonView.frame.size.height);
    } completion:nil];
    _editTextBtn.hidden = YES;
    _emoticonBtn.hidden = NO;
    _addBtn.hidden = NO;
}

-(void)testBackgroubColor
{
    _photoBtn.backgroundColor = [UIColor yellowColor];
    _mentionBtn.backgroundColor = [UIColor yellowColor];
    _trendBtn.backgroundColor = [UIColor yellowColor];
    _addBtn.backgroundColor = _photoBtn.backgroundColor;
    _emoticonBtn.backgroundColor = _photoBtn.backgroundColor;
    _editTextBtn.backgroundColor = _photoBtn.backgroundColor;
}
#pragma mark-初始化表情视图
-(void)initEmoticonView
{
    _emoticonView = [[EmoticonView alloc]initWithFrame:CGRectMake(0, 0, screenW, _inputView.frame.size.height)];
    _emoticonView.ebDelegate = self;
    [_inputView addSubview: _emoticonView];
}
//表情按钮点击触发的代理方法
-(void)emoticonBtnAction:(UIButton *)btn
{
    [self.kbDelegate emoBtnAction:btn.titleLabel.text];
    
}
-(void)imageBtnAction:(UIButton *)btn
{
    NSAttributedString *imageStr = [[[TextAndImageTool alloc]init] getStrByImage:btn.imageView.image andFontSize:20];
    UITextView *textView = (UITextView *)_owner;
    NSMutableAttributedString *mts = [[NSMutableAttributedString alloc]initWithAttributedString:textView.attributedText];
    [mts appendAttributedString:imageStr];
    textView.attributedText = mts ;
    textView.font = [UIFont systemFontOfSize:20];
    [textView.delegate textViewDidChange:textView];
    
//    UITextView *textView = (UITextView *)_owner;
//    NSMutableString *str = [NSMutableString stringWithFormat:@"%@%@",textView.text,btn.titleLabel.text];
//    textView.text = str;
//    textView.attributedText = [[[TextAndImageTool alloc]init] getAttributeStringByStr:str andFontSize:20];
    
}
-(void)deleteBtnAciton
{
    UITextView *textView = (UITextView *)_owner;
    [textView deleteBackward];
}
#pragma mark-初始化inputView
-(void)initInputView
{
    CGFloat h = (screenW * 1.0 / 7.0 )*(3+0.4+0.7);
    NSLog(@"%lf",h);
    _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, _locationBtn.frame.size.height + _toolBar.frame.size.height , screenW, h )];
    _inputView.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    [self addSubview:_inputView];
    [self initEmoticonView];
}
#pragma mark-位置改变的相关方法
-(void)updateSelfHighWithHigh:(CGFloat)h
{
    _editTextBtn.hidden = YES;
    _emoticonBtn.hidden = NO;
    _addBtn.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, screenH - h - _toolBar.frame.size.height - _locationBtn.frame.size.height , screenW , self.frame.size.height);
        self.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES ;
    }];
}
@end
