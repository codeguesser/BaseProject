//
//  CGTableView+loadView2.h
//  Base
//
//  Created by Justin on 14/9/5.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGTableView.h"
#import "CGView.h"
#define UIView_LoadViewShowHeader true//是否显示头部刷新
#define UIView_LoadViewShowFooter true//是否显示尾部加载
#define  UIView_LoadViewHeaderHeight 50//头部刷新的高度
#define UIView_LoadViewFooterHeight 60//底部加载的高度
@protocol UIView_LoadViewDelegate <NSObject>
@required
/**
 *  加载更多时的耗时操作，禁止在这里使用主线程的操作，如果必须要使用，请使用dispatch_after来实现
 */
-(void)loadMore;
/**
 *  刷新时的耗时操作，禁止在这里使用主线程的操作，如果必须要使用，请使用dispatch_after来实现
 */
-(void)refreshView;
/**针对父类的私有初始化内容**/
@optional
-(void)afterLoadMore;
-(void)afterRefreshView;
@end
@protocol UIViewLoadViewStateDelegate <NSObject>
-(void)loadViewStateDragToBeAction;//加载状态即将开始，实际上就是即将发生加载前的状态（箭头的动作）
-(void)loadViewStateLoading;//加载正在进行的状态
-(void)loadViewStateToBeDone;//加载完毕即将退出或者取消加载时的状态(箭头的动作)
-(void)loadViewStateDone;//加载结束状态
@end

/**
 *  关于本自定义控件 加载了上拉和下拉刷新的UITableview组件
 */

@interface CGTableView_loadView2 : CGTableView{
    id<UIViewLoadViewStateDelegate>_headerView;
    id<UIViewLoadViewStateDelegate>_footerView;
    float bottom;
    float top;
    /**针对父类的私有初始化内容**/
}
/**
 *  loadDelegate 非常重要，没有这个，你还不如自己用最简单的UITableView
 */
@property(nonatomic,weak)IBOutlet id<UIView_LoadViewDelegate>loadDelegate;
/**
 *  是否有头部
 */
@property(nonatomic,assign)BOOL isHeader;
/**
 *  是否有尾部
 */
@property(nonatomic,assign)BOOL isFooter;
/**
 *  是否自动加载数据，在初始化完毕之后
 */
@property(nonatomic,assign)BOOL isAutoLoadData;
/**
 *  手动加载数据
 *  isheader必须是true，refreshView必须实现，loadDelegate必须有值，否则不给玩咯
 */
-(void)startLoadData;
@end

@class LoadingView;
@interface UIView_HeaderView : CGView<UIViewLoadViewStateDelegate>{
    UIImageView *imageView;
    LoadingView *loadingView;
}
@end
@interface UIView_FooterView : CGView<UIViewLoadViewStateDelegate>{
    UIImageView *imageView;
    LoadingView *loadingView;
}
@end

@interface LoadingView : CGView{
    UIImageView *foreImageView;
    UIImageView *backImageView1;
    UIImageView *backImageView2;
}
@end
