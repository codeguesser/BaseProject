//
//  CGTextField.m
//  brochure
//
//  Created by wang shuguan on 13-12-14.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGTextField.h"

@implementation CGTextField
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
