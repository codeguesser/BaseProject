//
//  CGShowScrollView.h
//  club-card
//
//  Created by rsaif on 13-8-20.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import "CGScrollView.h"

@interface CGScrollViewShow : CGScrollView
/**
 *  哦，带偏移量，好像没啥用啊，如果想到怎么用请添加在这里
 *  除了这个问题以外，这个东东使用来做自动排队功能，有点像横着的table
 *  try your best
 */
@property(nonatomic,assign)UIEdgeInsets insets;
@end
