//
//  Soap.h
//  WANTTODIE
//
//  Created by Wangshuguan-mac on 13-7-3.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Soap : NSObject{
    NSString *soapMsg;
    NSString *actionKey;
    NSString *actionUrl;
    NSDictionary *returnDic;
}
/**
 *  生成soap对象
 *
 *  @param dic 来自本地的字典数据
 *  @param key 作为关键的key，用来写namespace的
 *  @param url 要提交的url
 *
 *  @return soap实体类
 */
- (id)initWithDic:(NSDictionary *)dic key:(NSString *)key url:(NSString *)url;
/**
 *  生成的SOAP字符串
 *
 *  @return 生成的SOAP字符串
 */
- (NSString *)soapMsg;
/**
 *  从Server请求回来的数据
 *
 *  @return 访问获取的数据用字典格式返回
 */
- (NSDictionary *)returnDic;
@end
