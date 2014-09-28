//
//  CGCollectionViewCell.m
//  brochure
//
//  Created by wang shuguan on 13-12-12.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGCollectionViewCell.h"

@implementation CGCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        [self Init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self Init];
    }
    return self;
}
-(void)Init{
    
}

@end
