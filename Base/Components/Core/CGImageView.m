//
//  CGImageView.m
//  contact
//
//  Created by wang shuguan on 13-12-3.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGImageView.h"

@implementation CGImageView

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
-(void)resizeSelf{
    float maxHeight = 0;
    for (UIView*v in self.subviews) {
        float tempHeight =  v.frame.size.height+v.frame.origin.y;
        if (tempHeight>maxHeight)maxHeight = tempHeight;
    }
    CGRect rect = self.frame;
    rect.size.height = maxHeight;
    self.frame = rect;
}
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size{
    CGRect f = CGRectMake(frame.origin.x+size.width, frame.origin.y+frame.size.height+size.height, self.frame.size.width, self.frame.size.height);
    self.frame = f;
}
-(void)resizeSelfWithOffsize:(CGSize)size{
    
    float maxWidth = 0;
    float maxHeight = 0;
    for (UIView*v in self.subviews) {
        float tempHeight =  v.frame.size.height+v.frame.origin.y;
        if (tempHeight>maxHeight)maxHeight = tempHeight;
    }
    maxWidth = self.frame.size.width;
    CGRect rect = self.frame;
    rect.size.height = maxHeight+size.height;
    rect.size.width = maxWidth+size.width;
    self.frame = rect;
}
-(void)makeSelfHiden{
    CGRect f = self.frame;
    f.size = CGSizeZero;
    self.frame = f;
}
@end
