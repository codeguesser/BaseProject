//
//  EntityObject.m
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "EntityObject.h"
#import "ManagedObject.h"
#import <CoreData+MagicalRecord.h>
@implementation NSNumber (String)
-(NSString *)toString{
    return [NSString stringWithFormat:@"%@",self];
}
@end


@implementation EntityObject
-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self toDictionary]];
}
+ (NSString *)model{
    return @"";
}
+ (NSArray *)allKeys{
    NSMutableArray *keys = [NSMutableArray new];
    Class cls = self;
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([key hasPrefix:@"_"])[keys addObject:key];
    }
    free(ivars);
    return keys;
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
    free(ivars);
    return dictionaryFormat;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    for (NSString *k in [self.class allKeys]) {
        NSString *key = [k substringFromIndex:1];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        for (NSString *k in [self.class allKeys]) {
            NSMutableString *methodString = [NSMutableString new];
            for (int i=0; i<k.length; i++) {
                if (i>0) {
                    if (i==1) {
                        [methodString appendString:[[NSString stringWithFormat:@"%c",[k characterAtIndex:i]] uppercaseString]];
                    }else{
                        [methodString appendString:[NSString stringWithFormat:@"%c",[k characterAtIndex:i]]];
                    }
                }
            }
            NSString *setStr = [NSString stringWithFormat:@"set%@:",methodString];
            SEL sel = NSSelectorFromString(setStr);
            if([self respondsToSelector:sel])[self performSelector:sel withObject:[aDecoder decodeObjectForKey:[k substringFromIndex:1]]];
        }
    }
    return self;
}
+(NSArray *)getObjecsFromDic:(id)dic{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if([dic isKindOfClass:[NSArray class]]){
        for (NSDictionary *d in dic) {
            [arr addObject:[self getObjectFromDic:d]];
        }
    }else if([dic isKindOfClass:[NSDictionary class]]){
        
        [arr addObject:[self getObjectFromDic:dic]];
    }
    return arr;
}
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic{
    return [EntityObject new];
}

+ (IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

+ (void) syncToCoreDataWithArray:(NSArray *)arr primaryKey:(NSString *)key{
    
}
+ (NSArray *) syncToArrayWithCoreData{
    NSMutableArray *dataList = [NSMutableArray new];
    if ([self.class model]&&[[self.class model] isKindOfClass:[NSString class]]&&NSClassFromString([self.class model])) {
        NSArray *fetchedObjects = [NSClassFromString([self.class model]) MR_findAll];
        NSEntityDescription *description = [NSEntityDescription entityForName:[self model] inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
        NSMutableArray *entityKeys = [NSMutableArray new];
        for (NSPropertyDescription *property in description) {
            [entityKeys addObject:property.name];
        }
        for (ManagedObject *e in fetchedObjects) {
            EntityObject *object = [[self class]new];
            for (NSString *key in [self allKeys]) {
                
                NSMutableString *methodString = [NSMutableString new];
                if ([key hasPrefix:@"_"]) {
                    for (int i=0; i<key.length; i++) {
                        if (i>0) {
                            if (i==1) {
                                [methodString appendString:[[NSString stringWithFormat:@"%c",[key characterAtIndex:i]] uppercaseString]];
                            }else{
                                [methodString appendString:[NSString stringWithFormat:@"%c",[key characterAtIndex:i]]];
                            }
                        }
                    }
                }
                NSString *setStr = [NSString stringWithFormat:@"set%@:",methodString];
                BOOL isSetValue = NO;
                for (NSString *key1 in entityKeys) {
                    if ([methodString.lowercaseString isEqualToString:key1.lowercaseString]) {
                        if([object respondsToSelector:NSSelectorFromString(setStr)])[object performSelector:NSSelectorFromString(setStr) withObject:[e valueForKey:key1]];
                        isSetValue = YES;
                    }
                }
                if (!isSetValue) {
                    if([object respondsToSelector:NSSelectorFromString(setStr)])[object performSelector:NSSelectorFromString(setStr) withObject:@""];
                }
            }
            [dataList addObject:object];
        }
    }
    return dataList;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self Init];
    }
    return self;
}
-(id)Init{
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
        IMP sidIMP = imp_implementationWithBlock(^(id _self, id string) {
            if([string isKindOfClass:[NSString class]])[_self setValue:string?string:@"" forKey:key];
            else if([string isKindOfClass:[NSNumber class]])[_self setValue:string?[NSString stringWithFormat:@"%@",string]:@"" forKey:key];
            else if (!string) {
                [_self setValue:string?string:@"" forKey:key];
            }
            else if ([string isKindOfClass:[NSNull class]]) {
                [_self setValue:@"" forKey:key];
            }else if ([string isKindOfClass:[NSArray class]]) {
                [_self setValue:string?string:@[] forKey:key];
            }else{
                [_self setValue:string forKey:key];
            }
        });
        NSMutableString *methodString = [NSMutableString new];
        if ([key hasPrefix:@"_"]) {
            for (int i=0; i<key.length; i++) {
                if (i>0) {
                    if (i==1) {
                        [methodString appendString:[[NSString stringWithFormat:@"%c",[key characterAtIndex:i]] uppercaseString]];
                    }else{
                        [methodString appendString:[NSString stringWithFormat:@"%c",[key characterAtIndex:i]]];
                    }
                }
            }
        }
        NSString *setStr = [NSString stringWithFormat:@"set%@:",methodString];
        SEL sel = NSSelectorFromString(setStr);
        [cls swizzleSelector:sel withIMP:sidIMP];
        
    }
    free(ivars);
    return self;
}
- (void)joinWithData:(EntityObject *)d{
    if ([NSStringFromClass(d.class) isEqualToString:NSStringFromClass(self.class)]) {
        for (NSString *k in [self.class allKeys]) {
            NSMutableString *methodString = [NSMutableString new];
            for (int i=0; i<k.length; i++) {
                if (i>0) {
                    if (i==1) {
                        [methodString appendString:[[NSString stringWithFormat:@"%c",[k characterAtIndex:i]] uppercaseString]];
                    }else{
                        [methodString appendString:[NSString stringWithFormat:@"%c",[k characterAtIndex:i]]];
                    }
                }
            }
            NSString *setStr = [NSString stringWithFormat:@"set%@:",methodString];
            SEL sel = NSSelectorFromString(setStr);
            
            if (
                ([[self valueForKey:[k substringFromIndex:1]] isKindOfClass:[NSString class]]&&[[self valueForKey:[k substringFromIndex:1] ] length]==0)||
                ([[self valueForKey:[k substringFromIndex:1]] isKindOfClass:[NSArray class]]&&[[self valueForKey:[k substringFromIndex:1] ] count]==0)
                ) {
                if([self respondsToSelector:sel])
                    [self performSelector:sel withObject:[d valueForKey:[k substringFromIndex:1]]];
            }
            
        }
    }
}


-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    BOOL isequal = YES;
    Class cls = [self class];
    unsigned int ivarsCnt = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([[object valueForKey:key] isKindOfClass:[NSString class]]&&![[object valueForKey:key]isEqualToString:[self valueForKey:key]])
        {
            isequal = NO;
        }
    }
    free(ivars);
    return isequal;
}
@end
