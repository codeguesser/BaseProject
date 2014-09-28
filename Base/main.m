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
//void changeTo2x(NSString *dir){
//    NSFileManager *file = [NSFileManager defaultManager];
//    for (NSString *s in [file contentsOfDirectoryAtPath:dir error:nil]) {
//        NSString *oldPath = s;
//        NSArray *newPathes = [oldPath componentsSeparatedByString:@"."];
//        if (newPathes.count==2) {
//            
//            NSString *newPath = [NSString stringWithFormat:@"%@@2x.%@",newPathes[0],newPathes[1]];
//            
//            [file moveItemAtPath:[dir stringByAppendingPathComponent:oldPath] toPath:[dir stringByAppendingPathComponent:newPath] error:nil];
//        }
//    }
//}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        URLLog(@"%@",DOCUMENT_DIR);
        NSString *sourceText=@"我爱中文";
        HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
        [outputFormat setToneType:ToneTypeWithoutTone];
        [outputFormat setVCharType:VCharTypeWithV];
        [outputFormat setCaseType:CaseTypeLowercase];
        NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
        URLLog(@"%@",outputPinyin);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
