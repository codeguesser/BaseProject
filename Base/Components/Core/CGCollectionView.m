//
//  CGCollectionView.m
//  brochure
//
//  Created by wang shuguan on 13-12-12.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGCollectionView.h"

@implementation CGCollectionView
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
        // Initialization code
        [self Init];
    }
    return self;
}

-(void)Init{
    
}

@end
