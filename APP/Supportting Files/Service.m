//
//  Service.m
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "Service.h"
#import <CoreData+MagicalRecord.h>
@implementation Service

-(CGDataResult *)getData{
//    [Entity MR_findAllInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    //sync coredata
//    NSArray *arr = [EntityItem syncToArrayWithCoreData];
//    [EntityItem syncToCoreDataWithArray:arr primaryKey:@"cid"];
    
    //search
//    NSArray *fetchedObjects = [Entity MR_findAll];
//    NSArray *newArr = [fetchedObjects sortedArrayUsingComparator:^NSComparisonResult(Entity * obj1, Entity * obj2) {
//        return [obj2.objectID.URIRepresentation.absoluteString compare:obj1.objectID.URIRepresentation.absoluteString];
//    }];
//    for (Entity *e in newArr) {
//        NSLog(@"--%@",e.name);
//        NSLog(@"--%@",e.cid);
//        NSLog(@"--%@",e.objectID);
//    }
    
    
    //save
//    NSError *error;
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        Entity *e = [Entity MR_createInContext:localContext];
//        e.name = @"name";
//        e.cid = @"cid";
//        e.cid = e.objectID.URIRepresentation.absoluteString;
//    }];
//    
//    if (error) URLLog(@"%@",error);
    
    
    //edit
//    NSError *error;
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        NSArray *fetchedObjects = [Entity MR_findAllInContext:localContext];
//        for (Entity *e in fetchedObjects) {
//            e.cid = @"cid1";
//        }
//    }];
//    
//    if (error) URLLog(@"%@",error);
    
    
    //del
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
//        NSArray *fetchedObjects = [Entity MR_findAllInContext:localContext];
//        for (Entity *e in fetchedObjects) {
//            [e MR_deleteInContext:localContext];
//        }
//    }];
    

    /**
     *  排序
     
     NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
     [request setFetchLimit:10];
     [request setFetchOffset:20];
     NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     [request setSortDescriptors:@[sortDescriptor]];
     NSArray *fetchedObjects = [Entity MR_executeFetchRequest:request inContext:[NSManagedObjectContext MR_defaultContext]];
     NSArray *newArr = [fetchedObjects sortedArrayUsingComparator:^NSComparisonResult(Entity * obj1, Entity * obj2) {
     return [obj2.objectID.URIRepresentation.absoluteString compare:obj1.objectID.URIRepresentation.absoluteString];
     }];
     for (Entity *e in newArr) {
     NSLog(@"--%@",e.name);
     NSLog(@"--%@",e.cid);
     NSLog(@"--%@",e.objectID);
     }
     
     */
    
    self.request.timeOutSeconds = 10;
    [self setProcessMore:^ NSDictionary *(NSDictionary * dic) {
        return @{};
    }];
    NSString   *url = [NSString stringWithFormat:@"http://www.dongben.cc/a.txt"];
    
    return [self loadNetworkDataWithUrl:url complete:^CGDataResult *(NSData *data,NSString * str,NSMutableDictionary *dic) {
        return [CGDataResult getResultFromDic:dic];
    }];
}
//本地化操作
//+(NSArray *)getGoodsFromLocal{
//    NSUserDefaults  *settings = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *arr = [NSMutableArray new];
//    for (NSData *d in [settings objectForKey:SHOPINGCHART_STR]) {
//        EntityGood *g = [NSKeyedUnarchiver unarchiveObjectWithData:d];
//        [arr addObject:g];
//    }
//    return arr;
//}
//+(BOOL)addGoodsToShoppingChart:(id)_good count:(NSString *)count{
//    EntityProduct *good = _good;
//    NSUserDefaults  *settings = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *arr;
//    if([settings objectForKey:SHOPINGCHART_STR])
//        arr = [[settings objectForKey:SHOPINGCHART_STR] mutableCopy];
//    else arr = [NSMutableArray new];
//    NSData *data ;
//    int index = -1;
//    int i = 0;
//    for (NSData *s in arr) {
//        EntityGood *g = [NSKeyedUnarchiver unarchiveObjectWithData:s];
//        if ([g.product.currentSpec.Id isEqualToString:good.currentSpec.Id]) {
//            g.count = strFromNum(@(g.count.intValue+count.intValue));
//            index = i;
//            data = [NSKeyedArchiver archivedDataWithRootObject:g];
//        }
//        i++;
//    }
//    if (index<0) {
//        EntityGood *g = [[EntityGood alloc] Init];
//        g.product = good;
//        g.count = count;
//        [arr addObject:[NSKeyedArchiver archivedDataWithRootObject:g]];
//    }else{
//        [arr replaceObjectAtIndex:index withObject:data];
//    }
//    [settings setObject:arr forKey:SHOPINGCHART_STR];
//    return [settings synchronize];
//}
//+(BOOL)delGoodFromShoppingChart:(NSString *)specId{
//    NSUserDefaults  *settings = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *arr;
//    if([settings objectForKey:SHOPINGCHART_STR])
//        arr = [[settings objectForKey:SHOPINGCHART_STR] mutableCopy];
//    else arr = [NSMutableArray new];
//    int index = -1;
//    int i = 0;
//    for (NSData *s in arr) {
//        EntityGood *g = [NSKeyedUnarchiver unarchiveObjectWithData:s];
//        if ([g.product.currentSpec.Id isEqualToString:specId]) {
//            index = i;
//        }
//        i++;
//    }
//    if (index>=0) {
//        [arr removeObjectAtIndex:index];
//    }
//    [settings setObject:arr forKey:SHOPINGCHART_STR];
//    return [settings synchronize];
//}

@end
