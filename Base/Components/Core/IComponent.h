//
//  IComponent.h
//  club-card
//  其实没啥用，组件的协议
//  Created by rsaif on 13-8-20.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IComponent <NSObject>
@optional
-(void)Init;
-(void)reloadSubViews;
@end
