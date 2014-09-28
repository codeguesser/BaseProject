//
//  CGButtonCheckBox.m
//  Contact
//
//  Created by shuguanwang on 14-3-20.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGButtonCheckBox.h"

@implementation CGButtonCheckBox
-(void)Init{
    [super Init];
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  这是选中状态能够其效果的主要原因，其实就是UIButton的selected状态
 */
-(void)clicked{
    self.selected = !self.isSelected;
}
@end
