//
//  CGCollectionViewCell.h
//  brochure
//
//  Created by wang shuguan on 13-12-12.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCollectionViewCell : UICollectionViewCell
/**
 *  传递的data，必须是实体类，也就是EnityObject的子类或者它本身
 */
@property(nonatomic,strong)id data;
/**
 *  indexPath，可以从table传递过来，当然这货再删除或者更改结构时就不可用了，因为没人刷新，请留意
 */
@property(nonatomic,strong)NSIndexPath *indexPath;
-(void)Init;
@end
