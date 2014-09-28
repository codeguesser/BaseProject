//
//  EntityObject.h
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//
#import <objc/runtime.h>
@import Foundation;

@class EntityObject;
@protocol ICGObject <NSObject>
@required
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic;
@optional
-(NSDictionary *)exportFromObject;
@end


@interface EntityObject : NSObject<ICGObject,NSCoding>
-(id)Init;
/**
 *  初始化之后做的事情
 *
 *  @param origSelector 原始方法
 *  @param newIMP       新方法
 *
 *  @return 不用管，只管实现它
 */
+ (IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP;
/**
 *  从字典中取出来，实体类变量组成的
 *
 *  @param dic 需要转换的字典
 *
 *  @return 实体类变量数组
 */
+ (NSArray *)getObjecsFromDic:(id)dic;
/**
 *  模型的名字
 *
 *  @return 获取在数据库中的模型，用于同步，当然这一版可能没有（version：5.1.1）
 */
+ (NSString *)model;//要关联的数据库模型
/**
 *  获取本类中所有的属性名
 *
 *  @return 属性名组成的数组
 */
+ (NSArray *)allKeys;//获取全部的field
/**
 *  将两个数据合并到对象里
 *
 *  @param d 新的数据来源
 */
- (void)joinWithData:(EntityObject *)d;

/**
 *  从当前实体类同步出来所有的实体数组
 *
 *  @return 实体类数组，从数据库中转换过来的
 */
+ (NSArray *) syncToArrayWithCoreData;



@end
@interface NSNumber (String)
/**
 *  NSNumber类型转字符串NSString类型
 *
 *  @return 转换之后的字符串
 */
-(NSString *)toString;
@end