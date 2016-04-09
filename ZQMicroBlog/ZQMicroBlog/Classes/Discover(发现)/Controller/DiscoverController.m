//
//  DiscoverController.m
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/23.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "DiscoverController.h"
#import "MySearchBarView.h"
#import "DiscoverTableViewCell.h"
#define Width 375
#define Height 667
#define IMAGEVIEW_TAG 2000
@interface DiscoverController ()<UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSArray *cellArr1;
    NSArray *cellArr2;
    NSArray *detailArr2;
    NSArray *cellArr3;
    NSMutableArray *_dataArray;
    UIScrollView *_ScrollV;
    
    UIScrollView *_scrollView;//广告
    NSMutableArray* _imageArray;
    NSTimer* _timer;//定时器
    UIPageControl* _pageControl;
    NSInteger _currentImageIndex;//当前显示图片
    BOOL _isFirst;//标记定时器方法是否是第一次调用
}
@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    MySearchBarView *searchView=[[MySearchBarView alloc]initWithFrame:CGRectMake(0, 20, 375, 40)];
    [self.navigationController.view addSubview:searchView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 106, Width,Height-32) style:UITableViewStylePlain];
    _tableView.scrollEnabled=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _ScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, Height)];
    _ScrollV.contentSize=CGSizeMake(Width, 810);
    [_ScrollV addSubview:_tableView];
    _ScrollV.bounces=NO;//滚动不能超出边界
    _ScrollV.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_ScrollV];
    
    _imageArray = [[NSMutableArray alloc] initWithArray:@[@"ad1.jpg",@"ad2.jpg",@"ad3.jpg",@"4.jpg"]];
    //创建UI
    [self createScrollView];//滚动视图
    [self createImageView];//图片
    [self createPageControl];//pagecontrol
    [self makeTimer];//定时器
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else if (section==1) {
        return cellArr1.count;
    }else if (section==2)
    {
        return cellArr2.count;
    }else
    {
        return cellArr3.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    if (indexPath.section==0) {
        DiscoverTableViewCell *cell=[[DiscoverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return cell;
    }else if (indexPath.section==1)
    {
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr1[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
    }else if (indexPath.section==2)
    {
        cell.textLabel.text=cellArr2[indexPath.row];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
        cell.detailTextLabel.text=detailArr2[indexPath.row];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(95, 10, 200, 25)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor lightGrayColor];
        label.text=detailArr2[indexPath.row];
        [cell addSubview:label];
    }else{
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=cellArr3[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.indentationLevel=2;
        cell.indentationWidth=20.0f;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)initData{
    cellArr1=[[NSArray alloc]initWithObjects:@"热门微博",@"找人", nil];
    
    cellArr2=[[NSArray alloc]init];
    cellArr2=@[@"游戏中心",@"应用",@"周边"];
    detailArr2=[NSArray new];
    detailArr2=@[@"",@"汇聚微博里最热门的APP",@"我们飞向更远的地方~"];
    
    cellArr3=[[NSArray alloc]init];
    cellArr3=@[@"奔跑2015",@"股票",@"听歌",@"购物",@"旅游",@"电影",@"更多频道"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
}
#pragma mark 创建UI
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,-55, self.view.frame.size.width, 160)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width*3, 150)];
    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    _scrollView.pagingEnabled = YES;
    //这个方法必须关闭，否则滑动时又白边效果
    _scrollView.bounces = NO;
    [_ScrollV addSubview:_scrollView];
}
- (void)createPageControl
{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width- (_imageArray.count*15)-40, 144-70, _imageArray.count*30, 30)];
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_ScrollV addSubview:_pageControl];
}
//创建imageView，并且贴上初始图片
- (void)createImageView
{
    _currentImageIndex = 0;
    for (int i = 0; i < 3; i ++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, 160)];
        imageView.tag = IMAGEVIEW_TAG + i;
        if (i == 1) {
            imageView.image = [UIImage imageNamed:_imageArray[0]];
        }else if (i == 0){
            imageView.image = [UIImage imageNamed:[_imageArray lastObject]];
        }else{
            imageView.image = [UIImage imageNamed:_imageArray[1]];
        }
        [_scrollView addSubview:imageView];
    }
    
}
- (void)makeTimer
{
    _isFirst = YES;
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:2 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (void)changeImage:(NSInteger)currtenIndex
{
    //提取imageView
    UIImageView* imageView = (UIImageView*)[_scrollView viewWithTag:IMAGEVIEW_TAG + 0];
    UIImageView* imageView1 = (UIImageView*)[_scrollView viewWithTag:IMAGEVIEW_TAG + 1];
    UIImageView* imageView2 = (UIImageView*)[_scrollView viewWithTag:IMAGEVIEW_TAG + 2];
    
    //三种情况转换imageView上的图片
    if (currtenIndex == _imageArray.count-1) {
        imageView1.image = [UIImage imageNamed:_imageArray[_currentImageIndex]];
        imageView2.image = [UIImage imageNamed:_imageArray[0]];
        imageView.image = [UIImage imageNamed:_imageArray[_currentImageIndex-1]];
    }else if (currtenIndex == 0){
        imageView1.image = [UIImage imageNamed:_imageArray[_currentImageIndex]];
        imageView2.image = [UIImage imageNamed:_imageArray[_currentImageIndex+1]];
        imageView.image = [UIImage imageNamed:[_imageArray lastObject]];
    }else{
        imageView1.image = [UIImage imageNamed:_imageArray[_currentImageIndex]];
        imageView2.image = [UIImage imageNamed:_imageArray[_currentImageIndex+1]];
        imageView.image = [UIImage imageNamed:_imageArray[_currentImageIndex-1]];
        
    }
}
#pragma mark UIScrollViewDelegate
//关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}
//开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self makeTimer];
}
//定时器需要走的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGPoint scrollViewPoint = _scrollView.contentOffset;
    if (scrollViewPoint.x > self.view.frame.size.width) {
        if (_currentImageIndex == _imageArray.count - 1) {
            _currentImageIndex = 0;
        }else{
            _currentImageIndex ++;
        }
    }else if(scrollViewPoint.x < self.view.frame.size.width){
        if (_currentImageIndex == 0) {
            _currentImageIndex = _imageArray.count-1;
        }else{
            _currentImageIndex --;
        }
    }
    //始终显示中间那张imageView
    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
    [self changeImage:_currentImageIndex];//调整图片
    _pageControl.currentPage = _currentImageIndex;
}
//拖拽需要走的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint scrollViewPoint = _scrollView.contentOffset;
    if (scrollViewPoint.x > self.view.frame.size.width) {
        if (_currentImageIndex == _imageArray.count - 1) {
            _currentImageIndex = 0;
        }else{
            _currentImageIndex ++;
        }
    }else if(scrollViewPoint.x < self.view.frame.size.width){
        if (_currentImageIndex == 0) {
            _currentImageIndex = _imageArray.count-1;
        }else{
            _currentImageIndex --;
        }
    }
    //始终显示中间那张imageView
    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
    [self changeImage:_currentImageIndex];//调整图片
    _pageControl.currentPage = _currentImageIndex;
}
#pragma mark 事件
- (void)scrollAction
{
    if (_isFirst == NO) {
        CGPoint scrollViewPoint = _scrollView.contentOffset;
        [_scrollView setContentOffset:CGPointMake(scrollViewPoint.x+self.view.frame.size.width, 0) animated:YES];
    }else{
        _isFirst = NO;
    }
}

@end
