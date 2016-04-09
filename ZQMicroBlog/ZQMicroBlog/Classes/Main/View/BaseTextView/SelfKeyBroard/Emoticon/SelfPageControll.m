//
//  SelfPageControll.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/1.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "SelfPageControll.h"

@implementation SelfPageControll
- (instancetype)initWithFrame:(CGRect)frame andTitleItems:(NSArray *)titleItems
{
    if (self = [super init]) {
        self.frame = frame;
//        self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
//        self.scrollEnabled = YES;
        CGFloat w = 0 ;
        if (titleItems.count > 4 ) {
            w = self.frame.size.width / 4 ;
        }
        else
        {
            w = self.frame.size.width/titleItems.count;
        }
        for (int i = 0 ; i < titleItems.count ; i++ ) {
            CGRect frame = CGRectMake(i * w, 0 , w , self.frame.size.height ) ;
            SelfPageItemButton *itemBtn = [[SelfPageItemButton alloc]initWithFrame:frame title:titleItems[i] andNum:i];
            itemBtn.spiDelegate = self ;
            [self addSubview:itemBtn];
        }
        SelfPageItemButton *itemBtn = self.subviews[0];
        [itemBtn btnAction:itemBtn];
    }
    return self;
}
-(void)addAciton:(UIButton *)btn
{
    if (self.pageDelegate == nil ) {
        _defaultSender.contentOffset = CGPointMake(_defaultSender.frame.size.width * btn.tag, 0);
    }
    else
    {
        [self.pageDelegate addAction:btn];
    }
}
-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    SelfPageItemButton *itemBtn = self.subviews[currentPage];
    [itemBtn buttonUp];
}

@end
