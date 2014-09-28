//
//  CGScrollViewShowGetSelected.m
//  clubCard
//
//  Created by wang shuguan on 13-11-18.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGScrollViewShowGetSelected.h"

@implementation CGScrollViewShowGetSelected
-(void)Init{
    [super Init];
    self.delegate = self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    NSUInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (_scrollViewShowDelegate&&[_scrollViewShowDelegate respondsToSelector:@selector(scrollViewShowGetSelectedAtIndex:)]) {
        [_scrollViewShowDelegate scrollViewShowGetSelectedAtIndex:(int)page];
    }
}

-(void)setIndex:(int)index{
    _index = index;
    [self scrollRectToVisible:CGRectMake(index*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}
@end
