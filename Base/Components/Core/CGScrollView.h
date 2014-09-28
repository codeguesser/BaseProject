//
//  CGScrollView.h
//  club-card
//
//  Created by rsaif on 13-8-20.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IComponent.h"
#import "ITouchDelegate.h"
@interface CGScrollView : UIScrollView<IComponent>
/**
 *  touch的delegate，用来承载touch事件的。。可能会用得到吧
 */
@property(nonatomic,weak)id<ITouchDelegate>touchDelegate;
/**
 *  子视图们
 */
@property(nonatomic,strong)NSMutableArray *views;
/**
 *  重新设置自己的contentSize
 */
-(void)resizeSelf;
/**
 *  重新设置contentsize，同时再加上偏移量
 *
 *  @param size 偏移量
 */
-(void)resizeSelfWithOffsize:(CGSize)size;
/**
 *  跟随某个frame，同时加个偏移量
 *
 *  @param frame 跟随的frame
 *  @param size  偏移量
 */
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size;
@end
