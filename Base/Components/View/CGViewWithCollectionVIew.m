//
//  CGViewWithCollectionVIew.m
//  brochure
//
//  Created by wang shuguan on 13-12-12.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGViewWithCollectionVIew.h"

@implementation CGViewWithCollectionVIew

-(void)Init{
    [super Init];
    nothingView = [[[NSBundle mainBundle] loadNibNamed:@"CGNothingView" owner:self options:nil] objectAtIndex:0];
}
-(void)showNothingView{
    if (![self.tableView.subviews containsObject:nothingView]) {
        [self.tableView addSubview:nothingView];
    }
    [nothingView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    nothingView.hidden = NO;
    [self.tableView bringSubviewToFront:nothingView];
}
-(void)hideNothingView{
    if ([self.tableView.subviews containsObject:nothingView]) {
        nothingView.hidden = YES;
    }
}
@end
