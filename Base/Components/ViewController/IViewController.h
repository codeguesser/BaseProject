//
//  IViewController.h
//  BaseProject
//
//  目测没啥用，主要是要建立这样的一个机制啦，
//  Created by lingzerg on 13-8-19.
//  Copyright (c) 2013年 lingzerg. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IViewController <NSObject>
/**
 *  重载一个view
 */
-(void)reloadView;
@end
