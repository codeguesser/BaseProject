//
//  UICollectionView+loadView2.m
//  Zhuangshi
//
//  Created by shuguan on 14-9-11.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "UICollectionView+loadView2.h"

@implementation MYLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self.collectionView layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}
@end
@implementation UICollectionView_loadView2
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self.frameDelegate layoutFrameFromIndexPath:indexPath];
    return attributes;
}
@end
