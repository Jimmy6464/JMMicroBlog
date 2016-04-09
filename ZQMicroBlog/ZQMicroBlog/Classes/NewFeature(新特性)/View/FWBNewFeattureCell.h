//
//  FWBNewFeattureCell.h
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/4.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWBNewFeattureCell : UICollectionViewCell
@property (nonatomic,strong)UIImage *image;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

- (void)setIndexPath:(NSIndexPath *)indexPath pagecount:(NSInteger)pagecount;
@end
