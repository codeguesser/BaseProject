//
//  Macro.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//  宏文件，所有的常用的工具都在这里，简写了许多东西，注意要把配置的常量信息放在config.h里面去

#ifndef Base_Macro_h
#define Base_Macro_h
#import "Language.h"
#import "ViewStyle.h"
#import "ShareHandle.h"
#import "CGNavigationController.h"
#pragma mark - ---------------------------------------------常量
#define BASE_PROJECT_VERSION 5.1.4


#define PROJECT_NAME [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"]
#define PROJECT_URL [[NSBundle mainBundle] infoDictionary][@"CFBundleURLTypes"][0][@"CFBundleURLSchemes"][0]


#pragma mark - ---------------------------------------------常用的函数

//TODO:应用沙盒目录
#define DOCUMENT_DIR [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) objectAtIndex:0]
//TODO:显示警告
#define SHOWMESSAGE(xx) {MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];[self.view addSubview:HUD];HUD.labelText = xx;HUD.mode = MBProgressHUDModeText;[HUD show:YES];[HUD hide:YES afterDelay:1];}

//TODO:判断IOS7设备
#define IS_IOS7_DEVICE [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0
//TODO:IOS7设备的不同API的调用
#define DiffApi(oldapi,newapi) ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)?newapi:oldapi

//TODO:常用的快捷方式
//TODO:转换Unicode字符串到UTF8
#define Uni2Utf8(unicodeStr) [[NSPropertyListSerialization propertyListFromData:[[[@"\""stringByAppendingString:[[unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]] stringByAppendingString:@"\""] dataUsingEncoding:NSUTF8StringEncoding] mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL] stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"]
#define UInt2Str(d)[NSString stringWithFormat:@"%lu",d]
#define strFromNum(n) [NSString stringWithFormat:@"%@",n]
//TODO:打印URL日志
#define URLLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//TODO:获取屏幕的宽高
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
//TODO:获取文字大小
#define TEXTSIZE(text, font, maxSize) [text length] > 0 ? ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]?[text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size:[text sizeWithFont:font constrainedToSize:maxSize]):CGSizeZero;

//TODO:判断IPHONE5设备
#define IS_IPHONE_5  ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//TODO:对象的快速创建
//TODO:获取当前设备的StoryBoard
#define SOTORYBOARD IS_IPHONE_5?@"MainStoryboard2":@"MainStoryboard2"
//TODO:从Storyboard加载ViewController
#define STORYBOARD_CONTROLLER(xx) [[UIStoryboard storyboardWithName:SOTORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:xx]
//TODO:用字符串创建一个ViewController
#define CreateViewController(classname) [[NSClassFromString(classname) alloc]initWithNibName:classname bundle:nil]
#define CreateViewControllerWithNav(classname) [[CGNavigationController alloc]initWithRootViewController:[[NSClassFromString(classname) alloc]initWithNibName:classname bundle:nil]]
//TODO:用字符串创建一个Cell
#define CreateCell(classname) [[[NSBundle mainBundle]loadNibNamed:classname owner:self options:nil] objectAtIndex:0]
#define CreateCollectionCell(classname) [[[NSBundle mainBundle]loadNibNamed:classname owner:self options:nil] objectAtIndex:0]
#endif