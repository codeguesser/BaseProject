//
//  SingletonHandle.h
//  Base
//
//  Created by rsaif on 14/10/21.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SingletonHandle : NSObject
+(id)shareHandle;
-(void)Init;
@end
