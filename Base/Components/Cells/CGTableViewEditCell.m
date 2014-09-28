//
//  CGTableViewEditCell.m
//  Jinmaque
//
//  Created by Justin on 14/8/27.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGTableViewEditCell.h"
@interface CGTableViewEditCell()<UIGestureRecognizerDelegate,UIScrollViewDelegate>{
    UIView *btDel;
    UIScrollView *scrollView;
    float currentX;
    float originX;
    float offsetX;
}
@end
#define BUTTON_WIDTH 132.0f
@implementation CGTableViewEditCell

-(void)Init{
    [super Init];
    self.accessoryType = UITableViewCellAccessoryNone;
    for (UIScrollView *v in self.subviews) {
        scrollView = v;
        scrollView.delegate = self;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(toucheMoved:)];
        pan.delegate = self;
        [scrollView addGestureRecognizer:pan];
//        self.showingDeleteConfirmation
//        [self ];
        btDel = [[UIView alloc]initWithFrame:self.frame];
        [btDel setBackgroundColor:[UIColor redColor]];
//        [btDel setTitle:@"删除" forState:0];
//        [self addSubview:btDel];
//        btDel.frame = CGRectMake(self.frame.size.width-BUTTON_WIDTH, 0, BUTTON_WIDTH, self.frame.size.height);
    });
}
-(void)layoutSubviews{
    [super layoutSubviews];
//
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}
-(void)toucheMoved:(UIPanGestureRecognizer *)g{
    
    CGPoint p = [g locationInView:g.view.superview];
    
    if (g.state==UIGestureRecognizerStateBegan) {
        originX = p.x;
        currentX = p.x;
        offsetX = scrollView.contentOffset.x;
        scrollView.contentSize = CGSizeMake(self.frame.size.width+offsetX, self.frame.size.height);
    }else if(g.state == UIGestureRecognizerStateEnded||g.state == UIGestureRecognizerStateCancelled){
//        if ((currentX-originX)<(-BUTTON_WIDTH/2.0f)) {
//            [scrollView setContentOffset:CGPointMake(BUTTON_WIDTH, 0) animated:YES];
//        }else{
//            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        }
    }else{
        if(originX-currentX+offsetX>=0&&originX-currentX+offsetX<=BUTTON_WIDTH)currentX = p.x;
        NSLog(@"%f",originX-currentX+offsetX);
        [scrollView setContentOffset:CGPointMake(originX-currentX+offsetX, 0)];
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)_scrollView{
    if (_scrollView.contentOffset.x>0) {
        
    }else
        [btDel removeFromSuperview];
}

@end
