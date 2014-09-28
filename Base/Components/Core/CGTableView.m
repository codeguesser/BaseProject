//
//  CGTableView.m
//  Base
//
//  Created by wang shuguan on 14-2-20.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGTableView.h"
@interface UITableView(Custom)
@end
@implementation UITableView (Custom)
//干掉IOS7的显示无结果
-(void)addSubview:(UIView *)view{
    [super addSubview:view];
    if ([view isKindOfClass:[UILabel class]]) {
        view.hidden = YES;
    }
}

@end
@implementation CGTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self Init];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self Init];
    }
    return self;
}
-(void)Init{

}
@end
