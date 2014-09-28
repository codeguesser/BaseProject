//
//  CustomUtil.m
//  club-card
//
//  Created by wang shuguan on 13-11-16.
//  Copyright (c) 2013年 rsaif. All rights reserved.
//

#import "CustomUtil.h"
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
@implementation CustomUtil

+(BOOL)isUserLogin{
    if ([USER_DEFAULT valueForKey:U_TOKEN]) {
        return YES;
    }else{
        return NO;
    }
}
+(void)saveAcessToken:(NSString *)token
{
    
    NSUserDefaults  *settings = USER_DEFAULT;
    [settings setObject:token forKey:U_TOKEN];
    [settings synchronize];
}
+(NSString *)getToken
{
    NSUserDefaults  *settings = USER_DEFAULT;
    return [settings valueForKey:U_TOKEN];
}
+(void)delAcessToken{
    NSUserDefaults  *settings = USER_DEFAULT;
    [settings removeObjectForKey:U_TOKEN];
    [settings synchronize];
}
//+(void)saveUserInfo:(EntityUser *)info{
//    NSUserDefaults  *settings = USER_DEFAULT;
//    
//    [settings setObject:[NSKeyedArchiver archivedDataWithRootObject:info] forKey:U_INFO];
//    [settings synchronize];
//}
//+(void)delUserInfo{
//    NSUserDefaults  *settings = USER_DEFAULT;
//    [settings removeObjectForKey:U_INFO];
//    [settings synchronize];
//}
//+(EntityUser *)getUserInfo{
//    NSUserDefaults  *settings = USER_DEFAULT;
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[settings valueForKey:U_INFO]];
//}
@end
