//
//  EffectCell.h
//  Zhuangshi
//
//  Created by shuguan on 14-9-10.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//
@protocol EffectCellDelegate <NSObject>

-(void)updateCell:(id)cell;

@end
#import "CGCollectionViewCell.h"

@interface EffectCell : CGCollectionViewCell{
    
    __weak IBOutlet UIImageView *_imgView;
}
@property(nonatomic,weak)id<EffectCellDelegate>delegate;

@end
