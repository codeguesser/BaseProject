//
//  PubuViewController.m
//  Base
//
//  Created by rsaif on 14/11/13.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "PubuViewController.h"
#import "EntityEffect.h"
#import "EffectCell.h"

@interface PubuViewController ()<EffectCellDelegate>

@end

@implementation PubuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(zuohua)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    _dataList = [NSMutableArray new];
    
    
     [_dataList addObjectsFromArray:[EntityEffect arrFromArr:@[@"http://wenwen.sogou.com/p/20110624/20110624050923-262735514.jpg",@"http://cdn.duitang.com/uploads/item/201111/09/20111109230753_kaeuy.thumb.600_0.jpg",@"http://wenwen.sogou.com/p/20110603/20110603170851-1624396958.jpg",@"http://www.28400.net/uploadfile/2011/1229/20111229113135683.jpg",@"http://cdn.duitang.com/uploads/item/201302/23/20130223133510_inBNW.thumb.600_0.jpeg",@"http://www.mofei.com.cn/fzl/UploadPic/2012/2012227142746921.jpg",@"http://images-fast.digu365.com/421cafb1be0cb5eb81b40e9f0edfacbf_0012.jpg",@"http://img1.3lian.com/img13/c4/98/d/61.jpg",@"http://tupian.qqjay.com/u/2013/0105/7_223430_13.jpg",@"http://wenwen.sogou.com/p/20111208/20111208195633-841302618.jpg",@"http://cdn.duitang.com/uploads/item/201303/23/20130323185807_rEvC4.jpeg",@"http://images-fast.digu365.com/eacd96d8511b26bf7c1024a0ea3f92bd_0009.jpg",@"http://e.hiphotos.baidu.com/zhidao/pic/item/c8177f3e6709c93d24dd514b9f3df8dcd100545a.jpg",@"http://img4.duitang.com/uploads/item/201302/23/20130223133436_BY4fZ.thumb.600_0.jpeg"]]];
    
    _collectionView.isFooter = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"EffectCell" bundle:nil] forCellWithReuseIdentifier:@"EffectCell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate for LoadViewDelegate
-(void)loadMore{
    
}
-(void)refreshView{
//    CGDataResult *h  = [[Service serviceWithRequest:[self createRequestWithPost:YES] ]effectHomege];
//    if (h.status.boolValue) {
//        [_dataList removeAllObjects];
//        //[_dataList addObjectsFromArray:h.dataList];
//        [_dataList addObjectsFromArray:h.dataList];
//    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EffectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EffectCell" forIndexPath:indexPath];
    cell.data = _dataList[indexPath.item];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataList.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    EntityEffect *e = _dataList[indexPath.item];
    
    return CGSizeMake(e.width.floatValue, e.height.floatValue);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}
#pragma mark - delegate for
-(CGRect )layoutFrameFromIndexPath:(NSIndexPath *)path{
    EntityEffect *e1 = _dataList[path.item];
    CGRect frame = CGRectMake(e1.x.floatValue, e1.y.floatValue, e1.width.floatValue, e1.height.floatValue);
    return frame;
}
#pragma mark - delegate for effectCell
-(void)updateCell:(id)_cell{
    EffectCell *cell = _cell;
    EntityEffect *e = cell.data;
    float lastY=0;
    if ([e.isUpdated isEqualToString:@"NO"]) {
        NSMutableArray *arr = [NSMutableArray new];
        for (NSInteger i=cell.indexPath.item; i<_dataList.count; i++) {
            EntityEffect *e1 = _dataList[i];
            if (i%3==0) {
                e1.x = @"3";
            }else if(i%3==1){
                e1.x = @"108";
            }else{
                e1.x = @"213";
            }
            if (i/3>=1) {
                EntityEffect *e2 = _dataList[i-3];
                e1.y = [NSString stringWithFormat:@"%f",e2.y.floatValue + e2.height.floatValue+5];
            }else{
                e1.y = 0;
            }
            lastY = MAX(e1.y.floatValue+e1.height.floatValue, lastY);
            [arr addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        [_collectionView reloadItemsAtIndexPaths:arr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _collectionView.contentSize = CGSizeMake(320, lastY);
        });
    }
}

@end
