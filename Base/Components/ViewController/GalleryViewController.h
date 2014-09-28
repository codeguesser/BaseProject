//
//  GalleryViewController.h
//  Jinmaque
//
//  Created by shuguan on 14-9-15.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "ViewControllerImpl.h"

@interface GalleryViewController : ViewControllerImpl{
    UIImageView *_imgView;
}
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)UIImage *img;
@end
