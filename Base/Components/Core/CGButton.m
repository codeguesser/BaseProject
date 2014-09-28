//
//  CGButton.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-5.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "CGButton.h"

@implementation CGButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self Init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self Init];
    }
    return self;
}
-(void)Init{
    
}
@end
