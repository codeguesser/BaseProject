//
//  ViewControllerImpl.h
//  BaseProject
//
//  Created by lingzerg on 13-8-19.
//  Copyright (c) 2013年 lingzerg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IViewController.h"
#import <MBProgressHUD.h>
#import <Toast+UIView.h>
#import "CGDataResult.h"
#import "Service.h"

#define COMPLETE_BLOCK void(^)(BOOL b,CGDataResult *r)
#define EXECUTE_BLOCK CGDataResult *(^)(ASIHTTPRequest * request)
@interface ViewControllerImpl : UIViewController<IViewController>
/**
 *  初始化之后要调用的函数
 */
- (void)Init;
/**
 *  显示一个loading条做延时加载操作
 *
 *  @param animated   是否显示那个loading条
 *  @param title      显示loading的作用
 *  @param block      要进行的延时事件
 *  @param completion 延时操作结束之后的事情
 */
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(EXECUTE_BLOCK)block completionBlock:(COMPLETE_BLOCK)completion;
/**
 *  显示一个loading条做延时加载操作，是对showAnimated:title:whileExecutingBlock:completionBlock:的延伸多态
 *
 *  @param animated   是否显示那个loading条
 *  @param title      显示loading的作用
 *  @param isPost     是否采用POST来加载数据
 *  @param block      要进行的延时事件
 *  @param completion 延时操作结束之后的事情
 */
- (void)showAnimated:(BOOL)animated title:(NSString *)title post:(BOOL)isPost whileExecutingBlock:(EXECUTE_BLOCK)block completionBlock:(COMPLETE_BLOCK)completion;
/**
 *  生成一个request
 *
 *  @param isPost 是否采用POST方法来请求
 *
 *  @return 生成的request
 */
- (ASIHTTPRequest *)createRequestWithPost:(BOOL)isPost;
/**
 *  上传一个数据
 *
 *  @param block      上传需要做的延时操作，好似没什么用
 *  @param url        上传使用的url
 *  @param dic        上传使用的para参数字典
 *  @param delegate   需要监听进度的对象Object，需要setProcess这样的方法的一个Object
 *  @param completion 结束后要做的事情
 */
- (void)uploadDataWithExecutingBlock:(NSString *(^)(ASIFormDataRequest *))block url:(NSString *)url para:(NSDictionary *)dic delegate:(id) delegate completionBlock:(void (^)(BOOL b))completion;
/**
 *  取消所有的加载
 */
- (void)cancelAllLoading;
/**
 *  隐藏键盘的命令，只要在本Viewcontroller，在任何地方均可调用隐藏键盘
 */
- (void)hideKeyBoard;
/**
 *  返回的操作
 */
- (IBAction)goBack;
@end

