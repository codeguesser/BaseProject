//
//  CGPickerView.h
//  Jinmaque
//
//  Created by Justin on 14/8/21.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPickerView : UIPickerView
-(void)Init;
-(void)resizeSelf;
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size;
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(dispatch_block_t)block completionBlock:(void (^)())completion;
-(void)resizeSelfWithOffsize:(CGSize)size;
@end
