//
//  UICollectionView+loadView2.h
//  Zhuangshi
//
//  Created by shuguan on 14-9-11.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//
@protocol UICollectionView_loadView2Delegate <NSObject>

-(CGRect )layoutFrameFromIndexPath:(NSIndexPath *)path;

@end
#import "UICollectionView+loadView.h"
@interface MYLayout : UICollectionViewFlowLayout
@end
@interface UICollectionView_loadView2 : UICollectionView_loadView
@property(nonatomic,weak)IBOutlet id <UICollectionView_loadView2Delegate>frameDelegate;
@end
