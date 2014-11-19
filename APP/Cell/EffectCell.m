//
//  EffectCell.m
//  Zhuangshi
//
//  Created by shuguan on 14-9-10.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "EffectCell.h"
#import "EntityEffect.h"

#import "UIImageView+WebCache.h"

@implementation EffectCell

-(void)layoutSubviews{
    [super layoutSubviews];
    EntityEffect *e = self.data;
    @autoreleasepool {
        _imgView.image = [UIImage imageWithContentsOfFile:[DOCUMENT_DIR stringByAppendingPathComponent:e.url.lastPathComponent]];
    }
    
}

@end
