//
//  CGService.m
//  Base
//
//  Created by Justin on 14-8-1.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGService.h"
#import "XMLReader.h"

@implementation CGService
-(CGDataResult  *)loadNetworkDataWithUrl:(NSString *)_url complete:(CGDataResult*(^)(NSData * data,NSString * str,NSMutableDictionary* dic))complete{
    NSLog(@"%@",[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    NSString *url = self.isSupportPercentMode?[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:_url;
    if ([self.request isKindOfClass:[ASIFormDataRequest class]]) {
        self.request.requestMethod = @"POST";
        NSArray *urls = [url componentsSeparatedByString:@"?"];
        if (urls.count==2) {
            NSString *realUrl = urls[0];
            NSString *para  = urls[1];
            NSArray *paras = [para componentsSeparatedByString:@"&"];
            for (NSString *p in paras) {
                NSMutableArray *keyValue = [NSMutableArray new];
                NSRange range = [p rangeOfString:@"="];
                if(range.length>0){
                    [keyValue addObject:[p substringToIndex:range.location]];
                    [keyValue addObject:[p substringFromIndex:range.location+1]];
                };
                if (keyValue.count>=2) {
                    [[self getPostRequest] setPostValue:keyValue[1] forKey:keyValue[0]];
                }
            }
            self.request.url = [NSURL URLWithString:realUrl];
        }else{
            self.request.url = [NSURL URLWithString:url];
        }
        
    }else{
        self.request.requestMethod = @"GET";
        self.request.url = [NSURL URLWithString:url];
    }
    [self.request startSynchronous];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *str;
    NSData *data;
    if (!self.coding) {
        if(self.request.responseString)str = Uni2Utf8(self.request.responseString);
        if ((!str)&&self.request.responseData) {
            str = [[NSString alloc]initWithData:self.request.responseData encoding:NSUTF8StringEncoding];
        }
        URLLog(@"%@",str);
        data = [str dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        str = [[NSString alloc]initWithData:self.request.responseData encoding:CFStringConvertEncodingToNSStringEncoding(self.coding)];
        data = [str dataUsingEncoding:NSUTF8StringEncoding];
    }
    if (self.request.isFinished) {
        if (!data) {
            [dic setValue:API_STR_ERROR forKey:API_STATUS];
            [dic setValue:@"网络错误" forKey:API_MSG];
            [dic setValue:[dic objectForKey:API_CONTENT] forKey:API_CONTENT];
        }else{
            if(data)[dic setValuesForKeysWithDictionary:[self getDicFromData:data]];
            if(str.length>0&&dic.allKeys.count==0){
                data = [[[str stringByReplacingOccurrencesOfString:@"\r" withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@""] dataUsingEncoding:NSUTF8StringEncoding];
                [dic setValuesForKeysWithDictionary:[self getDicFromData:data]];
            }
            if (![dic objectForKey:API_STATUS]) {
                
                if (self.isCareFormat) {
                    [dic setValue:API_STR_ERROR forKey:API_STATUS];
                    [dic setValue:@"网络错误" forKey:API_MSG];
                    [dic setValue:[dic objectForKey:API_CONTENT] forKey:API_CONTENT];
                }else{
                    dic[API_STATUS] = API_STR_TRUE;
                    dic[API_MSG] = @"加载完毕";
                    dic[API_CONTENT] = dic[API_CONTENT];
                }
            }else{
                if (dic.allKeys.count>3) {
                    //额外的数据需要重新加入字典
                    NSMutableDictionary *t_dic = [dic[[self necessaryWithDic:dic]] mutableCopy];
                    for (NSString *s in dic.allKeys) {
                        if (![self isDicKeyIsNecessaryWithKey:s]) {
                            if([t_dic isKindOfClass:[NSMutableDictionary class]])
                                t_dic[s] = dic[s];
                        }
                    }
                    
                    [dic setValue:t_dic forKey:[self necessaryWithDic:dic]];
                }
            }
        }
    }
    return complete(data,str,dic);
}
/**
 *  从data中生成dictionary
 *
 *  @param d data
 *
 *  @return 生成的字典
 */
-(NSDictionary *)getDicFromData:(NSData *)d{
    NSMutableDictionary *dic = [self.isXml?[XMLReader dictionaryForXMLData:d error:nil]:[NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers error:nil] mutableCopy];
    if (self.processMore) {
        return self.processMore(dic);
    }
    else return dic;
}
/**
 *  判断当前的这个key是不是非常重要，重要到可以作为内容的关键字
 *
 *  @param k 用来比较的key
 *
 *  @return yes就是这个key是非常重要的，用来作为内容的key
 */
-(BOOL)isDicKeyIsNecessaryWithKey:(NSString *)k{
#ifdef API_CONTENTS
    NSMutableArray *arr = [API_CONTENTS mutableCopy];
    [arr addObject:API_MSG];
    [arr addObject:API_STATUS];
    for (NSString *k1 in arr) {
        if ([k1 isEqualToString:k]) {
            return YES;
        }
    }
    return NO;
#else
    return [API_CONTENT isEqualToString:k];
#endif
}
/**
 *  从DIC数据集中提取重要的数据的key
 *
 *  @param dic dic数据集合
 *
 *  @return 用来作为内容的key
 */
-(NSString *)necessaryWithDic:(NSDictionary *)dic{
#ifdef API_CONTENTS
    for (NSString *s in dic.allKeys) {
        for (NSString *k1 in API_CONTENTS) {
            if ([k1 isEqualToString:s]) {
                return k1;
            }
        }
    }
    URLLog(@"如果你看到这个，说明，你的数据集合里也就是API_CONTENTS没有匹配的内容，添加一个关键字啦");
    return @"";
#else
    return API_CONTENT;
#endif
}
+(id)serviceWithRequest:(ASIHTTPRequest *)request{
    id s = [self new];
    [(CGService *)s setIsXml:NO];
    [(CGService *)s setIsCareFormat:YES];
    [(CGService *)s setRequest:request];
    [(CGService *)s setIsSupportPercentMode:YES];
    [(CGService *)s request].timeOutSeconds = 10;
    return s;
}
-(ASIHTTPRequest *)getRequest{
    return self.request;
}
-(ASIFormDataRequest *)getPostRequest{
    return (ASIFormDataRequest *)self.request;
}
@end
