//
//  CGTableView+loadView.m
//  Base
//
//  Created by Justin on 14-7-24.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGTableView+loadView.h"
typedef enum :NSInteger{
    UCGTableViewLoadStateLoading,//正在加载
    UCGTableViewLoadStateUnload,//加载结束
}UCGTableViewLoadState;
@interface CGTableView_loadView(){
    UIButton *bt;//顶部的那个加载
    UIButton *btLoadMore;//加载更多的那个底部加载按钮
    UCGTableViewLoadState loadState;//现在的加载状态
}
@end
@implementation CGTableView_loadView

-(void)Init{
    [super Init];
    loadState = UCGTableViewLoadStateUnload;
    
    //初始化加载更多
    btLoadMore = [UIButton new];
    btLoadMore.frame = CGRectMake(0, 0, 320, 44);
    self.tableFooterView = btLoadMore;
    UIActivityIndicatorView *loadingMoreIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingMoreIndicator.frame = CGRectMake(0, 0, 320, 44);
    [loadingMoreIndicator startAnimating];
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewLine.backgroundColor = [UIColor lightGrayColor];
    [btLoadMore addSubview:viewLine];
    [btLoadMore addSubview:loadingMoreIndicator];
    
    
    
    //初始化下拉加载的那个顶部加载
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , 320, 568)];
//    view.backgroundColor = [UIColor lightGrayColor];
    bt = [[UIButton alloc]initWithFrame:CGRectMake(0, -44 , 320, 44)];
    [bt setTitle:@"下拉刷新" forState:0];
    [bt setTitleColor:[UIColor blueColor] forState:0];
    [bt setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bt];
    self.backgroundView = view;
    self.backgroundColor = [UIColor clearColor];
    self.isFooter = YES;
    self.isHeader = YES;
    
    //让手势去监测现在下拉刷新的一个状态吧，这样可以让原本的的scrollview的委托解放出来
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        if (self.isHeader&&self.pulldelegate&&[self.pulldelegate respondsToSelector:@selector(doSomthingPullBySender:)]) {
            UIPanGestureRecognizer * pan = self.panGestureRecognizer;
            [pan addTarget:self action:@selector(endTouch:)];
        }
        
        
    });
    
    
//    CGAffineTransform transform =  CGAffineTransformIdentity;
//    transform = CGAffineTransformScale(transform, 1, -1);
//    btLoadMore.transform = transform;
//    bt.transform = transform;
}
-(void)setIsFooter:(BOOL)isFooter{
    _isFooter = isFooter;
    btLoadMore.hidden = !isFooter;
    if (!isFooter) {
        self.tableFooterView = nil;
    }
}
-(void)setIsHeader:(BOOL)isHeader{
    _isHeader = isHeader;
    bt.hidden = !isHeader;
}
-(void)setLoadString:(NSString *)loadStr{
//    [btLoadMore setTitle:loadStr forState:0];
}
/**
 *  手势引起的事件
 *
 *  @param g 手势
 */
-(void)endTouch:(UIPanGestureRecognizer * )g{
    if (g.state==UIGestureRecognizerStateEnded||g.state==UIGestureRecognizerStateCancelled) {
        //下滑结束时的事件
        if (loadState == UCGTableViewLoadStateUnload) {
            if (self.contentOffset.y<-44.0f&&self.isHeader) {
                //下滑允许加载时的动画
                [UIView animateWithDuration:.3f animations:^{
                    self.contentInset = UIEdgeInsetsMake(44.0f, 0, 0, 0);
                } completion:^(BOOL finished) {
                    
                    //动画结束后，改变当前状态为正在加载的状态，以及处理一些，数据加载的事情，
                    [bt setTitle:@"正在加载" forState:0];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        loadState = UCGTableViewLoadStateLoading;
                        [self.pulldelegate doSomthingPullBySender:self];//要耗时的事情
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [bt setTitle:@"加载完毕" forState:0];
                            [UIView animateWithDuration:.3f animations:^{
                                self.contentInset = UIEdgeInsetsMake(0.0f, 0, 0, 0);
                            } completion:^(BOOL finished) {
                                loadState = UCGTableViewLoadStateUnload;
                                if(![self.pulldelegate respondsToSelector:@selector(finishedDoSomthingPull:)])[self reloadData];
                                else [self.pulldelegate finishedDoSomthingPull:self];//耗时做完之后要做的事情
                            }];
                        });
                    });
                }];
            }
        }
    }
    [self performAnimate];
}
/**
 *  不停地监测当前的状态，超过界限改变当前的显示
 */
-(void)performAnimate{
    if (loadState == UCGTableViewLoadStateUnload) {
        if (self.contentOffset.y <= -44&&self.isHeader) {
            [bt setTitle:@"松手加载" forState:0];
        }else{
            [bt setTitle:@"下拉加载" forState:0];
        }
    }
    
    
}

-(void)setContentOffset:(CGPoint)contentOffset{
    [super setContentOffset:contentOffset];
    if (loadState == UCGTableViewLoadStateUnload&&self.pulldelegate&&[self.pulldelegate respondsToSelector:@selector(doSomthingPullDownBySender:)]&&self.isFooter){
        if (self.contentSize.height>self.frame.size.height){
            btLoadMore.hidden = NO;
            self.tableFooterView = btLoadMore;
            if (self.contentOffset.y+self.frame.size.height>self.contentSize.height-44.0) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    loadState = UCGTableViewLoadStateLoading;
                    [self.pulldelegate doSomthingPullDownBySender:self];//要耗时的事情
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        loadState = UCGTableViewLoadStateUnload;
                        
                        //耗时做完之后要做的事情
                        if ([self.pulldelegate respondsToSelector:@selector(finishedDoSomthingPullDown:)]) {
                            [self.pulldelegate finishedDoSomthingPullDown:self];
                            loadState = UCGTableViewLoadStateUnload;
                        }else{
                            [self reloadData];
                            loadState = UCGTableViewLoadStateUnload;
                        }
                    });
                });
            }
        }else{
            btLoadMore.hidden = YES;
            self.tableFooterView = nil;
        }
    }
    
}
@end
