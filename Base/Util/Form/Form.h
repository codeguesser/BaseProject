//
//  Form.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-5.
//  Copyright (c) 2013年 ling. All rights reserved.
//  需要组合着使用

#import <Foundation/Foundation.h>

@interface Form : NSObject
/**
 *  所有需要监测的控件，或者说组件，组成数组
 */
@property(nonatomic,retain)NSArray *views;
/**
 *  需要做的哪方面检查
 */
@property(nonatomic,retain)NSArray *checks;
/**
 *  辅助控件
 */
@property(nonatomic,retain)NSArray *otherViews;
/**
 *  自定义错误消息
 */
@property(nonatomic,retain)NSString *error;
/**
 *  错误编号
 */
@property(nonatomic,retain)NSNumber *errorIndex;
/**
 *  执行检查
 */
-(void)check;
@end
