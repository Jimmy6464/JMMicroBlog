//
//  TypeBtnView.h
//  dasdas
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeBtnViewDelegate<NSObject>
-(void)pushToBaseMicroblogEditController;
-(void)pushToEditLongMicrologController;
-(void)pushToGetPhotoController;
-(void)pushToRemarkMicrologController;
-(void)pushToLocationController;
-(void)gotoNextPage;
@end
@interface TypeBtnView : UIView
@property (nonatomic ,strong) UIButton *typeBtn;
@property (nonatomic ,strong) UILabel *typeLabel;
@property NSInteger num;
@property (nonatomic ,strong) id<TypeBtnViewDelegate> tbDelegate;
-(instancetype)initWithNum:(NSInteger)num andImage:(UIImage *)image andText:(NSString *)text;
@end
