//
//  EntityItem.m
//  contact
//
//  Created by wang shuguan on 13-11-30.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "EntityItem.h"

@implementation EntityItem
+ (NSString *)model{
    return @"Entity";
}
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    EntityItem *t = [[EntityItem new] Init];
    t.cid = [dic objectForKey:@"cid"];
    return t;
}
@end
