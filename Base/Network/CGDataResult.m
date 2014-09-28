//
//  CGDataResult.m
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGDataResult.h"
#import <objc/runtime.h>
#import "EntityObject.h"
@implementation CGDataResult
@synthesize errorMsg=_errorMsg,dataList=_dataList;
+(CGDataResult *)getResultFromDic:(NSDictionary *)dic className:(NSString *)classname{
    CGDataResult *result = [[CGDataResult alloc]init];
    if (dic&&([[dic objectForKey:API_STATUS] isKindOfClass:[NSString class]]||[[dic objectForKey:API_STATUS] isKindOfClass:[NSNumber class]])) {
        result.errorMsg = [dic objectForKey:API_MSG];
        result.status = [[[NSString stringWithFormat:@"%@",[dic objectForKey:API_STATUS]] lowercaseString]isEqualToString:API_STR_TRUE]?@(YES):@(NO);

        
        id datalist = [NSClassFromString(classname) getObjecsFromDic:[self getDictionaryFromDic:dic]];
        if (datalist) {
            result.dataList = datalist;
        }
    }
    return result;
}
+(NSDictionary *)getDictionaryFromDic:(NSDictionary *)dic{
#ifdef API_CONTENTS
    NSDictionary *newDic = @{};
    for (NSString *s in API_CONTENTS) {
        for (NSString *s1 in dic.allKeys) {
            if ([s isEqualToString:s1]) {
                newDic = dic[s1];
            }
        }
    }
    return newDic;
#else
    return [dic objectForKey:API_CONTENT];
#endif
}
+(CGDataResult *)getResultFromDic:(NSDictionary *)dic{
    CGDataResult *result = [[CGDataResult alloc]init];
    if (dic&&([[dic objectForKey:API_STATUS] isKindOfClass:[NSString class]]||[[dic objectForKey:API_STATUS] isKindOfClass:[NSNumber class]])) {
        result.errorMsg = [dic objectForKey:API_MSG];
        result.status = [[[NSString stringWithFormat:@"%@",[dic objectForKey:API_STATUS]] lowercaseString]isEqualToString:API_STR_TRUE]?@(YES):@(NO);
        id datalist = [self getDictionaryFromDic:dic];
        if (datalist) {
            result.dataList = datalist;
        }
    }
    return result;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self toDictionary]];
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
    
    //  取得当前类类型
    Class cls = [self class];
    
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
        if (value)
        {
            [dictionaryFormat setObject:value forKey:key];
        }
    }
    return dictionaryFormat;
}
@end
