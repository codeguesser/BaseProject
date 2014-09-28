//
//  UICollectionView+loadView.h
//  Yijia
//  和UITableview的上拉和下拉一样，反正是相当复杂的东东，懒得搞注释啦，any question please contact me at 915398434@qq.com
//  Created by shuguanwang on 14-3-17.
//  Copyright (c) 2014年 rsaif. All rights reserved.
//

#import "CGCollectionView.h"
#define UIViewCollection_LoadViewShowHeader true
#define UIViewCollection_LoadViewShowFooter true
#define  UIViewCollection_LoadViewHeaderHeight 50
#define UIViewCollection_LoadViewFooterHeight 60
@protocol UIViewCollection_LoadViewDelegate <NSObject>
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
///**针对父类的私有初始化内容**/
@end
@protocol UIViewCollectionLoadViewStateDelegate <NSObject>
-(void)loadViewStateDragToBeAction;
-(void)loadViewStateLoading;
-(void)loadViewStateToBeDone;
-(void)loadViewStateDone;
@end
@interface UICollectionView_loadView : CGCollectionView{
    id<UIViewCollectionLoadViewStateDelegate>_headerView;
    id<UIViewCollectionLoadViewStateDelegate>_footerView;
    float bottom;
    float top;
    /**针对父类的私有初始化内容**/
}
@property(nonatomic,weak)IBOutlet id<UIViewCollection_LoadViewDelegate>loadDelegate;
@property(nonatomic,assign)BOOL isHeader;
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

@class LoadingCollectionView;
@interface UIViewCollection_HeaderView : UIView<UIViewCollectionLoadViewStateDelegate>{
    UIImageView *imageView;
    LoadingCollectionView *loadingView;
}
@end
@interface UIViewCollection_FooterView : UIView<UIViewCollectionLoadViewStateDelegate>{
    UIImageView *imageView;
    LoadingCollectionView *loadingView;
}
@end

@interface LoadingCollectionView : UIView{
    UIImageView *foreImageView;
    UIImageView *backImageView1;
    UIImageView *backImageView2;
}
@end