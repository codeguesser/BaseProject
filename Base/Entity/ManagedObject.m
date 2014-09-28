//
//  ManagedObject.m
//  Contact
//
//  Created by Justin on 14-3-24.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "ManagedObject.h"
#import <objc/runtime.h>

@implementation ManagedObject

+(NSArray *)getObjecsFromDic:(id)dic{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if([dic isKindOfClass:[NSArray class]]){
        for (NSDictionary *d in dic) {
            [arr addObject:[self getObjectFromDic:d]];
        }
    }else if([dic isKindOfClass:[NSDictionary class]]){
        
        [arr addObject:[self getObjectFromDic:dic]];
    }
    return arr;
}
+(ManagedObject *)getObjectFromDic:(NSDictionary *)dic{
    return [ManagedObject new];
}

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self Init];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self Init];
    }
    return self;
}
-(void)Init{

}
@end
