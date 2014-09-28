//
//  CGDataResult.h
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//  结构体，用来存储来自服务端转化之后的数据

#import <Foundation/Foundation.h>

@interface CGDataResult : NSObject
/**
 *  服务器带来的消息，文本格式
 */
@property(strong,nonatomic)NSString *errorMsg;
/**
 *  服务器来的消息状态，BOOL的number类型
 */
@property(strong,nonatomic)NSNumber *status;
/**
 *  从服务器上来的真正的数据集合，任何类型，大部分是字典和数组，常见的是充满entity对象的数组
 */
@property(strong,nonatomic)id dataList;
/**
 *  将从服务器上拿来的字典转化成指定的实体类组成的数组
 *
 *  @param dic       服务器转化过来的字典
 *  @param classname 需要字典转成的实体类（Entity开头的对象）
 *
 *  @return 特殊格式CGDataResult的数据格式
 */
+(CGDataResult *)getResultFromDic:(NSDictionary *)dic className:(NSString *)classname;
/**
 *  将从服务器上拿来的字典转化成特殊数据格式，无需转成固定实体类，只需要字典
 *
 *  @param dic 来自服务器的字典
 *
 *  @return 转换之后的实体
 */
+(CGDataResult *)getResultFromDic:(NSDictionary *)dic;
@end