//
//  EmoticonView.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/30.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "EmoticonView.h"
@interface EmoticonView()
{
    NSMutableArray *_pageMarr;//用于储存表情页面，每一个元素是一页表情
    UIScrollView *_defaultEmoticon;//默认表情滚动视图
    UIScrollView *_emojiEmoticon;//emoji表情视图
    UIScrollView *_lxhEmoticon;//浪小花表情视图
    NSDictionary *_defaultRootDic;
    NSDictionary *_emojiRootDic;
    NSDictionary *_lxhRootDic;
    UIScrollView *_rootScrollView;
    SelfPageControll *_typeScrollView;
    UIView *_usedEmoticon;
    CGFloat w;
    CGFloat typeSvHigh;
}
@end
@implementation EmoticonView
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        w = frame.size.width/7 ;
        typeSvHigh = w * 0.7 ;
        
        [self initRootScrollView];
        [self initTypeScrollView];
    }
    return self;
}
-(void)initRootScrollView
{
    _rootScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-typeSvHigh)];
    _rootScrollView.contentSize = CGSizeMake(_rootScrollView.frame.size.width * 4, 0);
    _rootScrollView.contentOffset = CGPointMake(0, 0);
    _rootScrollView.backgroundColor = [UIColor redColor];
    _rootScrollView.tag = 30001;
    [self initUsedEmoticon];
    [self initdefaultEmoticon];
    [self initEmojiEmoticon];
    [self initLxhEmoticon];
    
    [self setScrollViewAttribute:_rootScrollView];
    _rootScrollView.alwaysBounceVertical = NO;
    [self addSubview:_rootScrollView];
}
//初始化最近使用过的表情
-(void)initUsedEmoticon
{
    _usedEmoticon = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _rootScrollView.frame.size.width, _rootScrollView.frame.size.height)];
    _usedEmoticon.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 3, 3 * w , self.frame.size.width / 3 , 0.4 * w)];
    lbl.text = @"最近使用的表情";
    lbl.textColor = [UIColor lightGrayColor];
    [_usedEmoticon addSubview:lbl];
    
    [_rootScrollView addSubview:_usedEmoticon];
}
-(void)initTypeScrollView
{
    CGRect frame = CGRectMake(0, self.frame.size.height - typeSvHigh , self.frame.size.width , typeSvHigh);
    _typeScrollView = [[SelfPageControll alloc]initWithFrame:frame andTitleItems:@[@"最近",@"默认",@"emoji",@"浪小花"]];
    _typeScrollView.pageDelegate = self ;
    [self addSubview:_typeScrollView];
}
#pragma mark- 3种表情的初始化
-(void)initdefaultEmoticon
{
    _defaultRootDic = [self getRootDicByFlieName:@"emoticon_default"];
    _defaultEmoticon = [self getScrollViewByRootDic:_defaultRootDic num:1];
}
-(void)initEmojiEmoticon
{
    _emojiRootDic = [self getRootDicByFlieName:@"emoticon_emoji"];
    _emojiEmoticon = [self getScrollViewByRootDic:_emojiRootDic num:2];
    
}
-(void)initLxhEmoticon
{
    _lxhRootDic = [self getRootDicByFlieName:@"emoticon_lxh"];
    _lxhEmoticon = [self getScrollViewByRootDic:_lxhRootDic num:3];
}
#pragma mark-根据根字典生成相应的表情
-(UIScrollView *)getScrollViewByRootDic:(NSDictionary *)rootDic num:(NSInteger)num
{
    NSString *ID = [rootDic objectForKey:@"id"];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(num * _rootScrollView.frame.size.width, 0 , _rootScrollView.frame.size.width, _rootScrollView.frame.size.height)];
    [self setScrollViewAttribute:sv];
    sv.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    sv.tag = 40000 + num;
    NSArray *nameArr = [rootDic objectForKey:@"emoticons"];
    UIView *pageView = [[UIView alloc]initWithFrame:_rootScrollView.frame];
    NSInteger numOfBtn = 0;
    NSInteger numOfPage = 0;
    for (int i = 0 ; i < nameArr.count ; i++ ) {
        if (numOfBtn % 20 == 0 && numOfBtn != 0) {
            UIButton *deleteBtn = [self getDeleteBtn];
            [pageView addSubview:deleteBtn];
            [sv addSubview:pageView];
            numOfBtn = 0 ;
            numOfPage ++ ;
            CGFloat x = sv.frame.size.width * numOfPage;
            CGFloat y = 0;
            CGFloat wight = sv.frame.size.width;
            CGFloat high = sv.frame.size.height;
            pageView = [[UIView alloc] initWithFrame:CGRectMake(x, y, wight, high)];
        }
        NSInteger x = numOfBtn % 7 ;
        NSInteger y = numOfBtn / 7 % 3 ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x * w , y * w, w, w);
        
        if ([ID isEqualToString:[_emojiRootDic objectForKey:@"id"]]) {
            nameArr = [self getEmojiEmoticonArrByCodeArr:nameArr];
            NSString *Str = nameArr[i];
            [btn setTitle:Str forState:UIControlStateNormal];
            btn.transform = CGAffineTransformScale(btn.transform, 1.5, 1.5);
//            [btn addTarget:self action:@selector(emojiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            
            NSString *imageName = [nameArr[i] objectForKey:@"png"];
            imageName = [imageName componentsSeparatedByString:@"."][0];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
//            [btn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.text = [nameArr[i] objectForKey:@"chs"];
            btn.titleLabel.textColor = [UIColor clearColor];
            btn.tag = i ;
        }
        [btn addTarget:self action:@selector(emojiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:btn];
        numOfBtn ++ ;
    }
    if (pageView != nil) {
        numOfPage ++ ;
        UIButton *deleteBtn = [self getDeleteBtn];
        [pageView addSubview:deleteBtn];
        [sv addSubview:pageView];
    }
    UIPageControl *page = [self getPageCByPageNum:numOfPage num:num andSuperViewFrame:self.frame];
    sv.contentSize = CGSizeMake(sv.frame.size.width * (numOfPage), sv.frame.size.height);
    [_rootScrollView addSubview:sv];
    [self addSubview:page];
    return sv ;
}
-(UIButton *)getDeleteBtn
{
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(6*w, 2*w, w, w);
    [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(deleteBtnAciton) forControlEvents:UIControlEventTouchUpInside];
    return deleteBtn;
}
-(void)deleteBtnAciton
{
    [self.ebDelegate deleteBtnAciton];
}
#pragma mark-根据总页数生成页视图
-(UIPageControl *)getPageCByPageNum:(NSInteger)pageNum num:(NSInteger)num andSuperViewFrame:(CGRect)frame
{
    CGFloat x = (frame.size.width-pageNum*10)/2;
    CGFloat y = w * 3 ;
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(x, y, pageNum * 10 , w*0.4)];
    page.tag = 50000 + num ;
    page.currentPage = 0;
    page.numberOfPages = pageNum;
    page.currentPageIndicatorTintColor = [UIColor orangeColor];
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    return page;
}
//根据文件名获取根数据字典
-(NSDictionary *)getRootDicByFlieName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *rootDic = [[NSDictionary alloc]initWithContentsOfFile:path];
    return rootDic;
}
#pragma mark-表情按钮的触发方法

-(void)emojiBtnAction:(UIButton *)sender
{
    [self.ebDelegate emoticonBtnAction:sender];
}
-(void)imageBtnAction:(UIButton *)sender
{
    [self.ebDelegate imageBtnAction:sender];
}
- (NSArray *)getEmojiEmoticonArrByCodeArr:(NSArray *)codeArr
{
    NSMutableArray *array = [NSMutableArray new];
//    for (NSDictionary *codeStr in codeArr) {
//        NSString *code = [codeStr objectForKey:@"code"];
//        NSScanner *sc = [[NSScanner alloc]initWithString:code];
//        int sym ;
//        [sc scanInt:&sym]
//        NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
//        [array addObject:emoT];
//    }
    
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }

    return array;
}
#pragma mark-滚动代理相关方法
-(void)setScrollViewAttribute:(UIScrollView *)sv
{
    sv.scrollEnabled = YES;
    sv.pagingEnabled = YES;
    sv.delegate = self;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.bounces = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag > 40000) {
        UIPageControl *page =(UIPageControl *) [self viewWithTag:50000+scrollView.tag - 40000];
        page.currentPage = scrollView.contentOffset.x / self.frame.size.width ;
    }
    else
    {
        if (scrollView.contentOffset.x < self.frame.size.width/2) {
            [self showRootPage:0];
        }
        else if (scrollView.contentOffset.x >= self.frame.size.width/2 && scrollView.contentOffset.x < self.frame.size.width * 1.5 )
        {
            [self showRootPage:1];
        }
        else if (scrollView.contentOffset.x >= 1.5*self.frame.size.width && scrollView.contentOffset.x < 2.5*self.frame.size.width )
        {
            [self showRootPage:2];
        }
        else if (scrollView.contentOffset.x >= 2.5*self.frame.size.width)
        {
            [self showRootPage:3];
        }
    }
}

-(void)showRootPage:(NSInteger)page
{
    _typeScrollView.currentPage = page;
    for (int i = 1 ; i < 4 ; i ++) {
        UIPageControl *pageC =(UIPageControl *) [self viewWithTag:50000+i];
        pageC.hidden = YES;
        if ( page == i) {
            pageC.hidden = NO;
            [self addSubview:pageC];
            
        }
    }
}

-(void)addAction:(UIButton *)btn
{
    _rootScrollView.contentOffset = CGPointMake(_rootScrollView.frame.size.width * btn.tag, 0);
    for (int i  = 1 ; i < 4 ; i++) {
        UIScrollView *sv = _rootScrollView.subviews[i];
        sv.contentOffset = CGPointMake(0, 0);
    }
}


@end
