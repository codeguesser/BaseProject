//
//  CGViewWithCollectionVIew.h
//  brochure

//  这货是带一个collectionView 的一个view啦，其实我都感觉有点定制化的感觉

//  Created by wang shuguan on 13-12-12.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGView.h"

#import "CGNothingView.h"

#import "ILoadView.h"
@interface CGViewWithCollectionVIew : CGView{
    CGNothingView *nothingView;
}
/**
 *  view中的那个CollectionView
 */
@property(nonatomic,strong)IBOutlet UICollectionView *tableView;
/**
 *  点击某项需要做的事情
 */
@property(nonatomic,weak)IBOutlet id<ILoadData>delegate;
/**
 *  提示没有数据
 */
-(void)showNothingView;
/**
 *  关闭没有数据
 */
-(void)hideNothingView;

@end
