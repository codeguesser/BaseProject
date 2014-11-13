//
//  PubuViewController.h
//  Base
//
//  Created by rsaif on 14/11/13.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "ViewControllerImpl.h"
#import "UICollectionView+loadView2.h"

@interface PubuViewController : ViewControllerImpl<UICollectionViewDelegate,UICollectionViewDataSource,UIViewCollection_LoadViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionView_loadView2Delegate>{
    NSMutableArray *_dataList;
    __weak IBOutlet UICollectionView_loadView2 *_collectionView;
}

@end
