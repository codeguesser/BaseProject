//
//  CGTableView+loadView2.m
//  Base
//
//  Created by Justin on 14/9/5.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGTableView+loadView2.h"
@import QuartzCore;
@interface CGTableView_loadView2()
-(void)loadHeaderView;
-(void)loadFooterView;
-(void)updateInsets;
@end
@implementation CGTableView_loadView2


-(void)Init{
    [super Init];
    /*针对父类的私有初始化内容*/
    
    
    
    /**公共方法**/
    top = 0;
    bottom =  0;
    _isFooter = YES;
    _isHeader = YES;
    _isAutoLoadData = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadHeaderView];
        //让手势去监测现在下拉刷新的一个状态吧，这样可以让原本的的scrollview的委托解放出来
        if (self.loadDelegate&&([self.loadDelegate respondsToSelector:@selector(loadMore)]||[self.loadDelegate respondsToSelector:@selector(refreshView)])) {
            UIPanGestureRecognizer * pan = self.panGestureRecognizer;
            [pan addTarget:self action:@selector(endTouch:)];
        }
        if (_isAutoLoadData) {
            [self startLoadData];
        }
    });
}

-(void)loadHeaderView{
    if (UIView_LoadViewShowHeader&&_isHeader) {
        if (!_headerView) {
            _headerView = [[UIView_HeaderView alloc]initWithFrame:CGRectMake(0, -UIView_LoadViewHeaderHeight, self.frame.size.width, UIView_LoadViewHeaderHeight)];
        }
        if (![self.subviews containsObject:_headerView]) {
            [self addSubview:(UIView_HeaderView *)_headerView];
        }
    }else{
        if (_headerView&&[[self subviews]containsObject:_headerView]) {
            [(UIView_HeaderView *)_headerView removeFromSuperview];
        }
    }
}
-(void)loadFooterView{
    if (UIView_LoadViewShowFooter&&_isFooter) {
        if (!_footerView) {
            _footerView = [[UIView_FooterView alloc]initWithFrame:CGRectMake(0, self.contentSize.height, self.frame.size.width, UIView_LoadViewFooterHeight)];
        }
        if (![self.subviews containsObject:_footerView]) {
            
            [self addSubview:(UIView_FooterView *)_footerView];
        }
        
        if (self.contentSize.height<=self.frame.size.height) {
            CGRect frame = [(UIView_FooterView *)_footerView frame];
            frame.origin.y = self.frame.size.height;
            [(UIView_FooterView *)_footerView setFrame:frame];
        }else{
            CGRect frame = CGRectMake(0, self.contentSize.height, self.frame.size.width, UIView_LoadViewFooterHeight);
            [(UIView_FooterView *)_footerView setFrame:frame];
        }
    }else{
        if (_footerView&&[[self subviews] containsObject:_footerView]) {
            [(UIView_FooterView *)_footerView removeFromSuperview];
        }
    }
}
-(void)startLoadData{
    if (_isHeader&&_loadDelegate&&[_loadDelegate respondsToSelector:@selector(refreshView)]) {
        [UIView animateWithDuration:.3 animations:^{
            top = UIView_LoadViewHeaderHeight;
            [self setContentOffset:CGPointMake(0, -top)];
            [self updateInsets];
        }completion:^(BOOL finished) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [_loadDelegate refreshView];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [_headerView loadViewStateDone];
                    if([_loadDelegate respondsToSelector:@selector(afterRefreshView)])
                        [_loadDelegate afterRefreshView];
                    else [self reloadData];
                    [UIView animateWithDuration:.3f animations:^{
                        top = 0;
                        [self updateInsets];
                    }];
                });
            });
        }];
        [_headerView loadViewStateLoading];
    }
}
/**
 *  手势引起的事件
 *
 *  @param g 手势
 */
-(void)endTouch:(UIPanGestureRecognizer * )g{
    CGPoint velocity = [g velocityInView:g.view];
    //下滑结束时的事件
    //此处手势事件，仅处理UI事件，至于scrollview本身现在进行到什么位置，由现在的更新地点决定
    if (self.isDragging) {
        
        //正在抓着，抓着产生的事件，上拉和下拉，亦或是返回
        if (UIView_LoadViewShowHeader&&_isHeader) {
            //启动下拉刷新
            if (self.contentOffset.y<-UIView_LoadViewHeaderHeight) {
                if (velocity.y>0) {
                    [_headerView loadViewStateToBeDone];
                }else{
                    [_headerView loadViewStateDragToBeAction];
                }
            }
        }
        else if (UIView_LoadViewShowFooter&&_isFooter) {
            //页脚加载更多，但是这里是contentsize足够大的情况
            if (self.contentOffset.y>self.contentSize.height-self.frame.size.height+UIView_LoadViewFooterHeight) {
                if (velocity.y>0) {
                    [_footerView loadViewStateToBeDone];
                }else{
                    [_footerView loadViewStateDragToBeAction];
                }
            }else if (self.contentSize.height<self.frame.size.height){
                //内容不足够大
                if (velocity.y>0) {
                    [_footerView loadViewStateToBeDone];
                }else{
                    [_footerView loadViewStateDragToBeAction];
                }
            }
        }
    }else{
        //抓取结束，确定是加载还是取消加载
        if (self.contentOffset.y<-UIView_LoadViewHeaderHeight&&UIView_LoadViewShowHeader&&_isHeader) {
            
            [UIView animateWithDuration:.3 animations:^{
                top = UIView_LoadViewHeaderHeight;
                [self updateInsets];
            }completion:^(BOOL finished) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [_loadDelegate refreshView];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [_headerView loadViewStateDone];
                        if([_loadDelegate respondsToSelector:@selector(afterRefreshView)])
                           [_loadDelegate afterRefreshView];
                        else [self reloadData];
                        [UIView animateWithDuration:.3f animations:^{
                            top = 0;
                            [self updateInsets];
                        }];
                    });
                });
            }];
            [_headerView loadViewStateLoading];
            
        }else if (UIView_LoadViewShowFooter&&_isFooter) {
            //页脚加载更多，但是这里是contentsize足够大的情况
            if (self.contentOffset.y>self.contentSize.height-self.frame.size.height+UIView_LoadViewFooterHeight) {
                
                [UIView animateWithDuration:.3f animations:^{
                    bottom = UIView_LoadViewFooterHeight;
                    [self updateInsets];
                }completion:^(BOOL finished) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [_loadDelegate loadMore];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [_footerView loadViewStateDone];
                            if ([_loadDelegate respondsToSelector:@selector(afterLoadMore)]) {
                                [_loadDelegate afterLoadMore];
                            }else{
                                [self reloadData];
                            }
                            [UIView animateWithDuration:.3f animations:^{
                                
                                bottom = 0;
                                [self updateInsets];
                            }];
                        });
                    });
                }];
                [_footerView loadViewStateLoading];
                
            }else if (self.contentSize.height<self.frame.size.height){
                //内容不足够大
                
                [UIView animateWithDuration:.3f animations:^{
                    
                    bottom = UIView_LoadViewFooterHeight;
                    [self updateInsets];
                }completion:^(BOOL finished) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [_footerView loadViewStateDone];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [_loadDelegate loadMore];
                            if ([_loadDelegate respondsToSelector:@selector(afterLoadMore)]) {
                                [_loadDelegate afterLoadMore];
                            }else{
                                [self reloadData];
                            }
                            [UIView animateWithDuration:.3f animations:^{
                                bottom = 0;
                                [self updateInsets];
                            }];
                        });
                    });
                }];
                [_footerView loadViewStateLoading];
                
            }
        }

    }
    
}
-(void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    [self loadFooterView];
}
-(void)updateInsets{
    self.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
}



@end

@implementation UIView_FooterView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:240/255.0f alpha:1];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refresh"]];
        [imageView setCenter:CGPointMake(frame.size.width/2.0f, frame.size.height/2.0f)];
        [self addSubview:imageView];
        
        loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(10, 10, 29, 10)];
        [loadingView setCenter:CGPointMake(frame.size.width/2.0f, frame.size.height/2.0f)];
        [self addSubview:loadingView];
        loadingView.hidden = YES;
    }
    return self;
}

-(void)loadViewStateDragToBeAction{//上拉未到中间点
    [UIView animateWithDuration:.3f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

-(void)loadViewStateLoading{//正在加载
    imageView.hidden = YES;
    loadingView.hidden = NO;
}
-(void)loadViewStateToBeDone{//加载前未松手
    [UIView animateWithDuration:.3f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(0);
    }];
}

-(void)loadViewStateDone{//加载结束
    imageView.hidden = NO;
    loadingView.hidden = YES;
}
@end
@implementation UIView_HeaderView
-(void)Init{
    [super Init];
    self.backgroundColor = [UIColor colorWithWhite:240/255.0f alpha:1];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refresh"]];
    [imageView setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:imageView];
    
    loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(10, 10, 29, 10)];
    [loadingView setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:loadingView];
    loadingView.hidden = YES;
}
-(void)loadViewStateDragToBeAction{//下拉未到中间点
    [UIView animateWithDuration:.3f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(0);
    }];
    //[@"" componentsSeparatedByString:@"&"].count>1
}
-(void)loadViewStateLoading{//正在加载
    imageView.hidden = YES;
    loadingView.hidden = NO;
}
-(void)loadViewStateToBeDone{//加载前未松手
    [UIView animateWithDuration:.3f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
-(void)loadViewStateDone{//加载结束
    imageView.hidden = NO;
    loadingView.hidden = YES;
}

@end
@implementation LoadingView
-(void)Init{
    [super Init];
    self.clipsToBounds = YES;
    
    
    backImageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ring"]];
    [self addSubview:backImageView1];
    backImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ring"]];
    [self addSubview:backImageView2];
    foreImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dot"]];
    [self addSubview:foreImageView];
    
    CGRect f1 = backImageView1.frame;
    f1.origin.x = 0;
    backImageView1.frame = f1;
    CGRect f2 = backImageView2.frame;
    f2.origin.x = -backImageView2.frame.size.width;
    backImageView2.frame = f2;
    
    
    CADisplayLink *link =[CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
    link.frameInterval = 1;
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)move{
    
    CGRect f1 = backImageView1.frame;
    f1.origin.x ++;
    if(f1.origin.x>foreImageView.frame.size.width)f1.origin.x = backImageView2.frame.origin.x-backImageView1.frame.size.width+3;
    backImageView1.frame = f1;
    CGRect f2 = backImageView2.frame;
    f2.origin.x ++;
    if(f2.origin.x>foreImageView.frame.size.width)f2.origin.x = backImageView1.frame.origin.x-backImageView2.frame.size.width+3;
    backImageView2.frame = f2;
    
}
@end