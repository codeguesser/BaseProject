//
//  CGScrollView.m
//  club-card
//
//  Created by rsaif on 13-8-20.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import "CGScrollView.h"

@implementation CGScrollView

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
-(void)resizeSelf{
    [self resizeSelfWithOffsize:CGSizeZero];
}
-(void)changeFrameByFollowedFrame:(CGRect)frame andOffsize:(CGSize)size{
    CGRect f = CGRectMake(frame.origin.x+size.width, frame.origin.y+frame.size.height+size.height, self.frame.size.width, self.frame.size.height);
    self.frame = f;
}
-(void)resizeSelfWithOffsize:(CGSize)size{
    
    float height = 0;
    float width = 0;
    for (UIView *v in self.subviews) {
        if (v.tag>0) {
            if (v.frame.size.height+v.frame.origin.y>height) {
                height = v.frame.size.height+v.frame.origin.y;
            }
            if (v.frame.size.width+v.frame.origin.x>width) {
                width = v.frame.size.width +v.frame.origin.x;
            }
        }
        
    }
    width+=size.width;
    height+=size.height;
    [self setContentSize:CGSizeMake(width, height)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchDelegate&&[_touchDelegate respondsToSelector:@selector(touchesBegan:bySender:)]) {
        [_touchDelegate touchesBegan:touches bySender:self];
        [_touchDelegate setIsTouching:YES];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchDelegate&&[_touchDelegate respondsToSelector:@selector(touchesMoved:bySender:)]) {
        [_touchDelegate touchesMoved:touches bySender:self];
        [_touchDelegate setIsTouching:YES];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchDelegate&&[_touchDelegate respondsToSelector:@selector(touchesEnded:bySender:)]) {
        [_touchDelegate touchesEnded:touches bySender:self];
        [_touchDelegate setIsTouching:NO];
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchDelegate&&[_touchDelegate respondsToSelector:@selector(touchesCancelled:bySender:)]) {
        [_touchDelegate touchesCancelled:touches bySender:self];
        [_touchDelegate setIsTouching:NO];
    }
}

@end
