//
//  CGShowScrollView.m
//  club-card
//
//  Created by rsaif on 13-8-20.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import "CGScrollViewShow.h"

@implementation CGScrollViewShow
@synthesize views = _views;
-(void)Init{
    [super Init];
    _views = [NSMutableArray new];
}
-(void)reloadSubViews{
    int i=0;
    float widthScreen=0;
    for (UIView *v in _views) {
        if([v isKindOfClass:[UIView class]]){
            CGRect vFrame = CGRectMake(v.frame.size.width*i+_insets.left, _insets.top, v.frame.size.width+_insets.right, v.frame.size.height+_insets.bottom);
            v.frame = vFrame;
            [self addSubview:v];
            widthScreen= vFrame.size.width+vFrame.origin.x>widthScreen?vFrame.size.width+vFrame.origin.x:widthScreen;
            i++;
        }
    }
    self.contentSize = CGSizeMake(widthScreen, self.frame.size.height);
}


@end
