//
//  FWBNewFeatureViewController.m
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/3.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "NewFeatureController.h"
#import "FWBNewFeattureCell.h"
@interface NewFeatureController ()
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation NewFeatureController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    //设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    //清空行距
    layout.minimumLineSpacing = 0;
    //设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}
//self.collectionView != self.view;
//注意self.collectionView 是 self.view的子控制器;

//使用UICollectionViewController
//1.初始化的时候设置布局参数
//2.必须注册cell
//3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor redColor];
  
    
    //设置分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加pageControl
    [self setUpPageControl];
}
#pragma mark - UICollectionViewDataSource
//有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
//返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //dequeueReusableCellWithReuseIdentifier
    //1.首先从缓存里取cell
    //2.看下当前是否有注册cell,如果注册了cell,就会帮你创建cell
    //3.没有注册会报错

    FWBNewFeattureCell *cell = [FWBNewFeattureCell cellWithCollectionView:collectionView indexPath:indexPath];
    [cell setIndexPath:indexPath pagecount:4];
    cell.backgroundColor = [UIColor yellowColor];
    
    //给cell传值
    
    //拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    cell.image = [UIImage imageNamed:imageName];
    return cell;
}
#pragma mark - 设置pagecontrol
- (void)setUpPageControl
{
    UIPageControl *page = [[UIPageControl alloc]init];
    page.center = CGPointMake(self.view.center.x, self.view.frame.size.height);
    page.numberOfPages = 4;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl = page;
    [self.view addSubview:page];
}
#pragma mark -设置page同步
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    
    _pageControl.currentPage = page;
    
    
}
@end
