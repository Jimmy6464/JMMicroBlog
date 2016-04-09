//
//  FWBMessageCell.m
//  Imate_MicroBlog
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "FWBMessageCell.h"
#import "FWBMessage.h"
#import "CellView.h"
@interface FWBMessageCell(){

}@end
@implementation FWBMessageCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(void)setMessageBase:(FWBMessage *)messageBase
{
    NSString *text=messageBase.text;
    
    CellView *cellView=[[CellView alloc]initWithFrame:CGRectMake(0, 0, 375, [self sizeWithString:text]+108)];
    cellView.messageBase=messageBase;
    [self addSubview:cellView];
    
}
- (CGFloat)sizeWithString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(360, 0)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    return rect.size.height;
}


@end
