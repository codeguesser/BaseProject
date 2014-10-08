//
//  CGDelegate.m
//  Base
//
//  Created by Justin on 14-8-1.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGDelegate.h"
#import <Appirater.h>
#import <KSCrash/KSCrash.h>
#import <KSCrash/KSCrashInstallationQuincyHockey.h>
#import <AlipaySDK/AlipaySDK.h>
@import CoreLocation;
@interface CGDelegate()<CLLocationManagerDelegate>{
#if U_SUPPORT_GPS==YES
    CLLocationManager *m;
#endif
}
@end
@implementation CGDelegate

-(id)init{
    if (self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationTerminate) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(open) name:UIApplicationWillTerminateNotification object:nil];
        
    }
    return self;
}
-(void)applicationFinishLaunching{
    [self setupDataBase];
    if([U_CRASH_URL length]>0)[self setupCrashRepot];
    if([U_APPID length]>0)[self setupRemindToRate];
    if(U_SUPPORT_GPS)[self setupGPS];
}
-(void)applicationTerminate{
    [MagicalRecord cleanUp];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

#pragma mark - 设置提醒用户评分
-(void)setupRemindToRate{
    [Appirater setAppId:U_APPID];
    [Appirater setDaysUntilPrompt:7];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
}
#pragma mark - 启用错误日志上传
-(void)setupCrashRepot{
    KSCrashInstallationQuincy* installation = [KSCrashInstallationQuincy sharedInstance];
    installation.url = [NSURL URLWithString:U_CRASH_URL];
    installation.userID = @"ABC123";
    installation.contactEmail = @"nobody@nowhere.com";
    installation.crashDescription = @"Something broke!";
    [installation install];
    
    [installation sendAllReportsWithCompletion:^(NSArray* reports, BOOL completed, NSError* error)
     {
     }];
}
#pragma mark - 启用数据库插件
-(void)setupDataBase{
    NSLog(@"%@",PROJECT_NAME);
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite",PROJECT_NAME]];
}
#pragma 启动GPS
-(void)setupGPS{
    
#if U_SUPPORT_GPS==YES
    m = [[CLLocationManager alloc] init];
    m.delegate = self;
    if ([m respondsToSelector:NSSelectorFromString(@"requestWhenInUseAuthorization")]){
        [m requestAlwaysAuthorization]; // 永久授权
        [m requestWhenInUseAuthorization]; //使用中授权
    }
    m.desiredAccuracy = kCLLocationAccuracyBest;
    m.distanceFilter = 1000.0f;
    [m startUpdatingLocation];
#endif
}
#if U_SUPPORT_GPS==YES
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (locations.count>0) {
        CLLocation *l = locations[0];
        URLLog(@"%f,%f",l.coordinate.latitude,l.coordinate.longitude);
        [ShareHandle shareHandle].shareLocation = l;
        [m stopUpdatingLocation];
    }
}
#endif
#pragma mark - 支付宝
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOderWithPaymentResult:url];
    }
    return YES;
}
@end
