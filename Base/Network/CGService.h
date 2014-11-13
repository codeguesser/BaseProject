//
//  CGService.h
//  Base
//
//  Created by Justin on 14-8-1.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGDataResult.h"
#import <ASIHTTPRequest.h>
#import <ASIFormDataRequest.h>
@interface CGService : NSObject
/**
 *  设定编码
 */
@property(nonatomic,assign) CFStringEncodings coding;
/**
 *  是否支持xml
 */
@property(nonatomic,assign)BOOL isXml;
/**
 *  是否支持在意完整格式，如果给予在意，那么如果获得的格式是错误的，就一定会提示网络错误，否则就是获取数据为空
 */
@property(nonatomic,assign)BOOL isCareFormat;
/**
 *  设置传递的参数是否需要改为百分号模式
 */
@property(nonatomic,assign)BOOL isSupportPercentMode;

/**
 *  通过request来获取Service对象
 *
 *  @param request 来自外部的request，因为request应该有controller保存，并决定其存留
 *
 *  @return service对象以实现各种数据请求
 */
+(id)serviceWithRequest:(ASIHTTPRequest *)request;
/**
 *  仅仅是获取一下request，无非常重大的用途
 */
@property(nonatomic,strong)ASIHTTPRequest *request;
/**
 *  获取当前service的request
 *
 *  @return 获取当前service的ASIHTTPRequest 格式的request，用于处理类似get的request
 */
-(ASIHTTPRequest *)getRequest;
/**
 *  获取当前service的request
 *
 *  @return 获取当前service的ASIHTTPRequest 格式的request，用于处理类似post的request
 */
-(ASIFormDataRequest *)getPostRequest;
/**
 *  请求网络，同时讲返回的数据转成各种格式，包括字符串、字典、最后将他们转换成CGDataResult这种格式
 *
 *  @param _url     想要请求的链接，url为要传递链接以及参数
 *  @param complete 完成之后要做的事情，主要是从里面的三个参数身上取值
 *
 *  @return 固定格式
 */
-(CGDataResult  *)loadNetworkDataWithUrl:(NSString *)_url complete:(CGDataResult*(^)(NSData * data,NSString * str,NSMutableDictionary* dic))complete;
/**
 *  对解析到的dic进行重新封装，其实就是更多处理
 */
@property(nonatomic,assign)NSDictionary* (^processMore)(NSDictionary *dic);
@end
