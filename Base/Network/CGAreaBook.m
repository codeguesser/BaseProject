//
//  CGAreaBook.m
//  Jinmaque
//
//  Created by Justin on 14/8/21.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGAreaBook.h"
@implementation CGAreaBookProvince : NSObject
-(NSArray *)dataList{
    return _citys;
}
-(NSString *)value{
    return _name;
}
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return [other isKindOfClass:[self class]]&&[[(id<WSGViewAreaProtocal>)other value] isEqualToString:[self value]];
    }
}

@end
@implementation CGAreaBookCity : NSObject
-(NSArray *)dataList{
    return _districts;
}
-(NSString *)value{
    return _name;
}
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return [other isKindOfClass:[self class]]&&[[(id<WSGViewAreaProtocal>)other value] isEqualToString:[self value]];
    }
}
@end
@implementation CGAreaBookDistrict : NSObject
-(NSArray *)dataList{
    return @[];
}
-(NSString *)value{
    return _name;
}
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return [other isKindOfClass:[self class]]&&[[(id<WSGViewAreaProtocal>)other value] isEqualToString:[self value]];
    }
}
@end
@implementation CGAreaBook
+(NSArray *)getAreaBooks{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString *s1 in dic.allKeys) {
        NSDictionary *d1 = dic[s1];
        for (NSString *s2 in d1.allKeys) {
            //省
            CGAreaBookProvince *province = [CGAreaBookProvince new];
            province.name = s2;
            NSMutableArray *citys = [NSMutableArray new];
            NSDictionary *d2 = d1[s2];
            for (NSString *s3 in d2.allKeys) {
                NSDictionary *d3 = d2[s3];
                for (NSString *s4 in d3.allKeys) {
                    //市区
                    CGAreaBookCity *city = [CGAreaBookCity new];
                    city.name = s4;
                    NSMutableArray *ditricts = [NSMutableArray new];
                    NSArray *d5 = d3[s4];
                    for (NSString *s5 in d5) {
                        //区
                        CGAreaBookDistrict *district = [CGAreaBookDistrict new];
                        district.name = s5;
                        [ditricts addObject:district];
                    }
                    city.districts = ditricts;
                    [citys addObject:city];
                }
            }
            province.citys = citys;
            [arr addObject:province];
        }
    }
    return arr;
}
@end
