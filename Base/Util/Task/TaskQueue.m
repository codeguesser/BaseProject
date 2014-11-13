//
//  TaskQueue.m
//  Base
//
//  Created by 王书倌 on 14/10/23.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "TaskQueue.h"
#import <ASIHTTPRequest.h>
#import <CoreData+MagicalRecord.h>
@implementation Task
@end
@implementation TaskCoreData
-(void)cancel{
    [NSManagedObjectContext ]
}
@end
@implementation TaskNetwork
-(void)cancel{
    [(ASIHTTPRequest *)self.taskTarget clearDelegatesAndCancel];
}
@end

@implementation TaskQueue
- (instancetype)init
{
    self = [super init];
    if (self) {
        operation = [[NSOperationQueue alloc]init];
        tasks = [NSMutableArray new];
    }
    return self;
}
-(void)addTask:(Task *)t{
    [tasks addObject:t];
    [operation addOperationWithBlock:t.block];
    
}

@end
