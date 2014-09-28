//
//  CGViewController.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-11.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "CGViewController.h"

@interface CGViewController ()

@end

@implementation CGViewController

-(void)Init{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self Init];
    }
    return self;
}
- (id)init
{
    self = [super init];
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
-(IBAction)goBack:(id)sender{
    if (self.navigationController&&self.navigationController.viewControllers.count>1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)dismissNavigationViewController{
    if (self.navigationController) {
        
        [UIView beginAnimations:@"animate" context:nil];
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [UIView commitAnimations];
    }
}
@end
