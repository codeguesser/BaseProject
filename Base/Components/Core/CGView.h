//
//  CGView.h
//  contact
//
//  Created by wang shuguan on 13-11-28.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGView : UIView
/**
 *  初始化
 */
-(void)Init;
/**
 *  重新改变自己的大小
 */
-(void)resizeSelf;
/**
 *  跟随一个frame 同时加上偏移量
 *
 *  @param frame 跟随的frame
 *  @param size  偏移量
 */
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size;
/**
 *  跟Viewcontroller一样价格显示loading条的东西
 *
 *  @param animated   是否显示黑色的条
 *  @param title      提示loading的内容
 *  @param block      延时的操作
 *  @param completion 延时操作完成之后的操作
 */
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(dispatch_block_t)block completionBlock:(void (^)())completion;
/**
 *  重新设置自己的大小，同时做一些大小的偏移
 *
 *  @param size 偏移量
 */
-(void)resizeSelfWithOffsize:(CGSize)size;
@end
