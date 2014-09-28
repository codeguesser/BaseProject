//
//  CropView.h
//  testClip

//  这货是用来剪裁图片用的，算是个简易的大头贴，就是用来剪裁图片上传之用的

//  Created by rsaif on 13-8-16.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropView : UIView<UIScrollViewDelegate>{
    UIScrollView *backgroundScrollView;
    UIImageView *imageView;
    
    UIImageView *maskView;
    UIView *frameView;
}
/**
 *  剪裁后的图片
 *
 *  @return 当前剪裁后的图片
 */
-(UIImage *)cropedImage;
/**
 *  初始化时的背景图片
 *
 *  @param image 初始图片
 */
-(void)setBackgroundImage:(UIImage *)image;
@end
