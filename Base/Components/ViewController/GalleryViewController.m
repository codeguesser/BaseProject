//
//  GalleryViewController.m
//  Jinmaque
//
//  Created by shuguan on 14-9-15.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "GalleryViewController.h"
#import "UIImageView+WebCache.h"
@interface GalleryViewController ()<UIScrollViewDelegate>

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    scollView.bouncesZoom = YES;
    scollView.maximumZoomScale = 10;
    scollView.minimumZoomScale = 0.5;
    scollView.backgroundColor = [UIColor clearColor];
    scollView.autoresizesSubviews = YES;
    scollView.delegate = self;
    [self.view addSubview:scollView];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    _imgView.autoresizesSubviews = YES;
    _imgView.userInteractionEnabled = NO;
    if(_img)_imgView.image = _img;
    else [_imgView sd_setImageWithURL:[NSURL URLWithString:_url] placeholderImage:DefaultImage];
    [scollView addSubview:_imgView];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMySelf)];
    [scollView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideMySelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgView;
}
@end
