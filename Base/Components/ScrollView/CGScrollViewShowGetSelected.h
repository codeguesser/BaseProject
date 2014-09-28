//
//  CGScrollViewShowGetSelected.h
//  clubCard
//
//  点击该控件提示，当前属于scrollview 的第几页啦
//  Created by wang shuguan on 13-11-18.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//
@protocol CGScrollViewShowDelegate <NSObject>
@optional
/**
 *  点击scrollview的时候给出当前的页码
 *
 *  @param index 页码
 */
-(void)scrollViewShowGetSelectedAtIndex:(int)index;
@end
#import "CGScrollViewShow.h"

@interface CGScrollViewShowGetSelected : CGScrollViewShow<UIScrollViewDelegate>
/**
 *  设置点击后让谁来发生些事情
 */
@property(nonatomic,weak)id<CGScrollViewShowDelegate>scrollViewShowDelegate;
/**
 *  当前页面，也可以设置现在是第几页，也就是跳页的功能啦
 */
@property(nonatomic,assign)int index;
@end
