//
//  CustomUtil.h
//  club-card
//
//  Created by wang shuguan on 13-11-16.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import <Foundation/Foundation.h>
#define U_TOKEN @"TOKEN"
#define U_INFO @"INFO"



@interface CustomUtil : NSObject

+(BOOL)isUserLogin;
+(void)saveAcessToken:(NSString *)token;
+(void)delAcessToken;
+(NSString *)getToken;


//+(void)saveUserInfo:(EntityUser *)info;
//+(void)delUserInfo;
//+(EntityUser *)getUserInfo;


@end
