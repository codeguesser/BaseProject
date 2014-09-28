//
//  CGTableViewCell.m
//  contact
//
//  Created by wang shuguan on 13-12-3.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGTableViewCell.h"

@implementation CGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
-(void)Init{
}

-(CGSize)getContentSize{
    float maxHeight = 0;
    float maxWidth = 0;
    for (UIView *v in self.contentView.subviews) {
        if (v.frame.size.width+v.frame.origin.x>maxWidth) {
            maxWidth =v.frame.size.width+v.frame.origin.x;
        }
        if (v.frame.size.height+v.frame.origin.y>maxHeight) {
            maxHeight = v.frame.size.height+v.frame.origin.y;
        }
    }
    return CGSizeMake(maxWidth, maxHeight);
}

@end
