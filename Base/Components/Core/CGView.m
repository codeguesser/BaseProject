//
//  CGView.m
//  contact
//
//  Created by wang shuguan on 13-11-28.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGView.h"
@implementation CGView

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
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(dispatch_block_t)block completionBlock:(void (^)())completion {
#ifdef MB_INSTANCETYPE
    MBProgressHUD *HUD;
    //初始化进度框，置于当前的View当中
    HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    HUD.labelText = title;
	[HUD showAnimated:animated whileExecutingBlock:block onQueue:queue completionBlock:completion];
#endif
}
-(void)resizeSelfWithOffsize:(CGSize)size{
    
    float maxWidth = 0;
    float maxHeight = 0;
    for (UIView*v in self.subviews) {
        float tempHeight =  v.frame.size.height+v.frame.origin.y;
        if (tempHeight>maxHeight)maxHeight = tempHeight;
    }
    CGRect rect = self.frame;
    rect.size.height = maxHeight+size.height;
    rect.size.width = maxWidth+size.width;
    self.frame = rect;
}
@end
