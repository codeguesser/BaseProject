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
#import "SDWebImageDownloader.h"
@interface PubuViewController ()<EffectCellDelegate>
@end

@implementation PubuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(zuohua)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    _dataList = [NSMutableArray new];
    
    
    _collectionView.isFooter = NO;
    UINib *nib = [UINib nibWithNibName:@"EffectCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"EffectCell"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate for LoadViewDelegate
-(void)loadMore{
    
}
-(void)refreshView{
    CGDataResult *h  = [[Service serviceWithRequest:[self createRequestWithPost:YES] ]effectHomege];
    if (h.status.boolValue) {
        for (EntityEffect *e in h.dataList) {
            [self getNewImageWithData:e];
        }
        float leftY = 0;
        float rightY = 0;
        int index = 0;
        for (EntityEffect *e in h.dataList) {
            if (leftY<rightY) {
                e.x = @"5";
                e.y = [NSString stringWithFormat:@"%f",leftY];
                leftY = leftY+e.height.floatValue+5;
            }else{
                e.x = [NSString stringWithFormat:@"%f",SCREEN_WIDTH/2.0f+5];
                e.y = [NSString stringWithFormat:@"%f",rightY];
                rightY = rightY+e.height.floatValue+5;
            }
            index++;
        }
        
        [_dataList removeAllObjects];
        [_dataList addObjectsFromArray:h.dataList];
    }
}
-(void)getNewImageWithData:(EntityEffect *)e{
    
    NSString *filePath = [DOCUMENT_DIR stringByAppendingPathComponent:e.url.lastPathComponent];
    NSString *path2 = [NSString stringWithFormat:@"l_%@.%@",[e.url.lastPathComponent stringByDeletingPathExtension],e.url.lastPathComponent.pathExtension];
    NSString *largeFilePath = [DOCUMENT_DIR stringByAppendingPathComponent:path2];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        @autoreleasepool {
            NSData *imgData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:e.url]] returningResponse:nil error:nil];
            e.isUpdated = @"YES";
            UIImage *img = [self smallImageWithImage:[UIImage imageWithData:imgData]];
            [UIImageJPEGRepresentation(img, 0) writeToFile:filePath atomically:YES];
            e.width = [NSString stringWithFormat:@"%f",img.size.width];
            e.height = [NSString stringWithFormat:@"%f",img.size.height];
            [imgData writeToFile:largeFilePath atomically:YES];
        }
    }else{
        UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        e.width = [NSString stringWithFormat:@"%f",img.size.width];
        e.height = [NSString stringWithFormat:@"%f",img.size.height];
        
    }
    
}
-(UIImage *)smallImageWithImage:(UIImage *)img{
    UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH/2.0f-10, img.size.height*(SCREEN_WIDTH/2.0f-10)/img.size.width));
    [img drawInRect:CGRectMake(0, 0, SCREEN_WIDTH/2.0f-10, img.size.height*(SCREEN_WIDTH/2.0f-10)/img.size.width)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)afterRefreshView{
    [_collectionView reloadData];
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
    URLLog(@"%f",frame.origin.x);
    return frame;
}
#pragma mark - delegate for effectCell
-(void)updateCell:(id)_cell{

}

@end
