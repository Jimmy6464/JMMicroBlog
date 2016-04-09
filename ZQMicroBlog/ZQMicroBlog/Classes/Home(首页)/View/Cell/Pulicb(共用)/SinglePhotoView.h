//
//  SinglePhotoView.h
//  ZQMicroBlog
//
//  Created by Jimmy on 15/11/28.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photoes.h"
/**
 *  单张图类
 */
@interface SinglePhotoView : UIImageView
@property (nonatomic,strong) Photoes *photo;
@end
