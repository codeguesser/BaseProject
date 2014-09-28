//
//  ManagedObject.h
//  Contact
//
//  Created by Justin on 14-3-24.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//  可以无视了，这货不太容易进行方法的重写，因为这货的属性都是@dynamic的
#import <CoreData/CoreData.h>
#import "EntityObject.h"
@interface ManagedObject : NSManagedObject<ICGObject>
+(NSArray *)getObjecsFromDic:(id)dic;
-(void)Init;
@end