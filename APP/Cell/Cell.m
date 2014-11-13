//
//  Cell.m
//  Base
//
//  Created by rsaif on 14/11/12.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "Cell.h"

@implementation Cell
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.text = self.data;
}

@end
