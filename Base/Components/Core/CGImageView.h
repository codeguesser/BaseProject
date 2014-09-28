//
//  CGImageView.h
//  contact
//  所有ImageView的基类，当然希望能够多用他，如果你要重写UIimageView的话，本空间带了很多奇葩功能，so还是继承它会比较好。。
//  Created by wang shuguan on 13-12-3.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGImageView : UIImageView
/**
 *  初始化
 */
-(void)Init;
/**
 *  重新通过子视图重新绘制自己的大小
 */
-(void)resizeSelf;
/**
 *  根据前一个frame进行跟随实现自适应下推的功能
 *
 *  @param frame 要跟随的frame
 *  @param size  跟随frame的偏移量
 */
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size;
/**
 *  同时根据偏移量改变自身大小
 *
 *  @param size 偏移量
 */
-(void)resizeSelfWithOffsize:(CGSize)size;
/**
 *  隐藏自己，其实是把自身的大小设置成0，欺骗自己啊。。。
 */
-(void)makeSelfHiden;
@end
