//
//  labelInsets.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-28.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "CGALabelInsets.h"

@implementation CGALabelInsets

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 20, 10, 10);
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, inset)];
}
-(void)reloadSize{
    [super reloadSize];
    CGSize size = self.frame.size;
    CGRect rect = self.frame;
    size.width = self.frame.size.width;
    size.height += 35;
    rect.size = size;
    self.frame = rect;
}
@end
