//
//  ITouchDelegate.h
//  brochure
//  手指头碰触事件
//  Created by wang shuguan on 13-12-14.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITouchDelegate <NSObject>
@optional
-(void)touchesBegan:(NSSet *)touches bySender:(UIView *)sender;
-(void)touchesMoved:(NSSet *)touches bySender:(UIView *)sender;
-(void)touchesEnded:(NSSet *)touches bySender:(UIView *)sender;
-(void)touchesCancelled:(NSSet *)touches bySender:(UIView *)sender;
@property(nonatomic,assign)BOOL isTouching;
@end
