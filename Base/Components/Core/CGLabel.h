//
//  CGLabel.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-12.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLabel : UILabel
/**
 *  初始化
 */
-(void)Init;
/**
 *  跟随一个frame，改变自己的坐标，实现自适应
 *
 *  @param frame 被跟踪的frame
 *  @param size  偏移量
 */
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size;
/**
 *  根据自己的字的多少，重新设置宽高，实现自适应
 */
-(void)reloadSize;
@end
