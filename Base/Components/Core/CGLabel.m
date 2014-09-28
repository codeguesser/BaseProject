//
//  CGLabel.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-12.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "CGLabel.h"

@implementation CGLabel
-(void)Init{
    
}
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

-(void)reloadSize{
    
    self.numberOfLines = 0;
    [self sizeToFit];
}
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size{
    CGRect f = CGRectMake(frame.origin.x+size.width, frame.origin.y+frame.size.height+size.height, self.frame.size.width, self.frame.size.height);
    self.frame = f;
}
@end
