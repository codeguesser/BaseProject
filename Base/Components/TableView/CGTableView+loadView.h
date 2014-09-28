//
//  CGTableView+loadView.h
//  Base
//
//  这货是新型的下拉加载和点击刷新，优化了一些东西，起码不必写大量的协议了
//
//  Created by Justin on 14-7-24.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

@protocol CGTableViewDelegate <NSObject>
@optional
/**
 *  下拉刷新要做的延时操作
 *
 *  @param sender 其实就是tableview本身
 */
-(void)doSomthingPullBySender:(id)sender;
/**
 *  下拉刷新之后的UI操作
 *
 *  @param sender 其实就是tableview本身
 */
-(void)finishedDoSomthingPull:(id)sender;

/**
 *  加载更多要做的延时操作
 *
 *  @param sender 其实就是tableview本身
 */
-(void)doSomthingPullDownBySender:(id)sender;
/**
 *  加载更多之后的UI操作
 *
 *  @param sender 其实就是tableview本身
 */
-(void)finishedDoSomthingPullDown:(id)sender;
@end
#import "CGTableView.h"
/// CGTableView_loadView : CGTableView 这货是新型的下拉加载和点击刷新，优化了一些东西，起码不必写大量的协议了
@interface CGTableView_loadView : CGTableView
/**
 *  设置委托，不影响tableview本身的委托
 */
@property(nonatomic,weak)IBOutlet id<CGTableViewDelegate>pulldelegate;
/**
 *  设置是否需要头部
 */
@property(nonatomic,assign)BOOL isHeader;
/**
 *  设置是否需要底部
 */
@property(nonatomic,assign)BOOL isFooter;
/**
 *  这个是要设置加载更多的那个字符串
 *
 *  @param loadStr 要设置的字符串
 */
-(void)setLoadString:(NSString *)loadStr;
@end
