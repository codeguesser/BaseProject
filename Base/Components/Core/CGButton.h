//
//  CGButton.h
//  WTD
//  所有Button的基类
//  Created by Wangshuguan-mac on 13-7-5.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IButton.h"
@interface CGButton : UIButton<IButton>
/**
 *  button的初始化之后的所作的事情
 */
-(void)Init;
@end
