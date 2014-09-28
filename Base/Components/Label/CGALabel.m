//
//  CGALabel.m
//  contact
//
//  Created by wang shuguan on 13-12-10.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGALabel.h"

@implementation CGALabel
-(void)setText:(NSString *)text{
    [super setText:text];
    [self reloadSize];
}

@end
