//
//  SingletonHandle.m
//  Base
//
//  Created by rsaif on 14/10/21.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "SingletonHandle.h"

@implementation SingletonHandle
+(id)shareHandle{
    static ShareHandle *sh;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sh = [[ShareHandle alloc]init];
    });
    return sh;
}
- (id)init
{
    self = [super init];
    if (self) {
        //do sth here
        [self Init];
    }
    return self;
}
-(void)Init{
}
@end
