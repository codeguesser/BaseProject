//
//  ShareHandle.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "ShareHandle.h"
#import "Config.h"
#import "ViewStyle.h"
@implementation ShareHandle
+(ShareHandle *)shareHandle{
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
    }
    return self;
}

@end
