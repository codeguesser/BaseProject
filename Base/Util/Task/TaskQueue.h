//
//  TaskQueue.h
//  Base
//
//  Created by 王书倌 on 14/10/23.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//
@protocol ITask <NSObject>
@optional
-(void)cancel;
@end
#import <Foundation/Foundation.h>

@interface Task :NSObject<ITask>
@property(nonatomic,strong)id taskTarget;
@property(nonatomic,strong)void(^block)(void);

@end
@interface TaskCoreData : Task
@end
@interface TaskNetwork : Task
@end
@interface TaskQueue : NSObject{
    NSOperationQueue *operation;
    NSMutableArray *tasks;
}
-(void)addTask:(Task *)t;
-(void)cancelAll;
@end
