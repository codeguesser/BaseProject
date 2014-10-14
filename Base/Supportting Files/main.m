//
//  main.m
//  Base
//
//  Created by wang shuguan on 14-2-20.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PinYin4Objc.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        URLLog(@"%@",DOCUMENT_DIR);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
