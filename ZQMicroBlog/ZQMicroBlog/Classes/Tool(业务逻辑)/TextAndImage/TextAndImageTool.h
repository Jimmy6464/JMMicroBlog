//
//  TextAndImageTool.h
//  ZQMicroBlog
//
//  Created by Ibokan on 15/12/4.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextAndImageTool : NSObject
-(NSAttributedString *)getAttributeStringByStr:(NSString *)str withInfoNameArr:(NSArray *)nameArr andFontSize:(CGFloat)fontSize;
-(NSAttributedString *)getStrByImage:(UIImage *)image andFontSize:(CGFloat)fontSize;
-(NSAttributedString *)getAttributeStringByStr:(NSString *)str andFontSize:(CGFloat)fontSize;
-(NSString *)getStrByAttributeStr:(NSAttributedString *)attributeStr;
@end
