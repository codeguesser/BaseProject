//
//  Style.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "ViewStyle.h"
#import <QuartzCore/QuartzCore.h>
@implementation ViewStyle
- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
-(void)applyBorderStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:193.0/255.0f green:193.0/255.0f blue:193.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 1.0f;
    v.layer.cornerRadius = 4.0;  //设置layer圆角半径
    v.layer.masksToBounds = YES;  //隐藏边界
}
-(void)applyClickedBorderStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:133.0/255.0f green:133.0/255.0f blue:128.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 1.0f;
    v.layer.cornerRadius = 4.0;  //设置layer圆角半径
    v.layer.masksToBounds = YES;  //隐藏边界
}
-(void)applyGroupBorderStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:193.0/255.0f green:193.0/255.0f blue:193.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 1.0f;
    v.layer.cornerRadius = 2.0;  //设置layer圆角半径
    v.layer.masksToBounds = YES;  //隐藏边界
}
-(void)applyTranspondBorderStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:193.0/255.0f green:193.0/255.0f blue:193.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 1.0f;
    v.layer.cornerRadius = 4.0;  //设置layer圆角半径
    v.layer.masksToBounds = YES;  //隐藏边界
}
-(void)applyOrangeBorderStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:214.0/255.0f green:161.0/255.0f blue:72.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 2.0f;
    v.layer.cornerRadius = 2.0;  //设置layer圆角半径
    v.layer.masksToBounds = YES;  //隐藏边界
}
-(void)applyShadawStyle:(UIView *)v{
    v.layer.shadowColor = [UIColor blackColor].CGColor;
    v.layer.shadowOffset = CGSizeMake(1, 1);
    v.layer.shadowRadius = 0;
    v.layer.shadowOpacity = 1.0;
}
-(void)applyBorderNoRoundStyle:(UIView *)v{
    v.layer.borderColor = [UIColor colorWithRed:193.0/255.0f green:193.0/255.0f blue:193.0/255.0f alpha:1.0f].CGColor;
    v.layer.borderWidth = 1.0f;
}
@end
