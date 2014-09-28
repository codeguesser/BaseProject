//
//  CGNavigationController.m
//  brochure
//
//  Created by wang shuguan on 13-12-15.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGNavigationController.h"

@interface CGNavigationController ()

@end

@implementation CGNavigationController
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    if ([vc isKindOfClass:NSClassFromString(@"ViewControllerImpl")]) {
        [vc performSelector:NSSelectorFromString(@"cancelAllLoading")];
    }
    return vc;
}
@end
