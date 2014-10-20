//
//  Config.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-4.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#ifndef Base_Config_h
#define Base_Config_h
#import "Macro.h"
#pragma mark - ---------------------------------------------常量
//设置web服务接口
#define CURRENTxmlns @"http://tempuri.org/"
#define HOSTDOMAIN @"192.168.2.52"
#define WEBSEARVICE  [NSString stringWithFormat:@"http://%@:8060/WebService.asmx",HOSTDOMAIN]

#define LOADCOUNT @10

//设置初始化字体大小
#define FirstFontSize [UIFont systemFontOfSize:20.0f]
#define SecondFontSize [UIFont systemFontOfSize:14.0f]
//TODO:系统颜色
#define DefaultColor [UIColor colorWithRed:236/255.0f green:240/255.0f blue:241/255.0f alpha:1]
#define DefaultImage [UIImage imageNamed:@"img_pic_bg"]

//设置Webservice变量结构
#define API_STATUS @"success"
#define API_CONTENT @"result"
//#define API_CONTENTS @[@"result",@"service",@"goods",@"order"]//是否包含多个结果字段名
#define API_MSG @"msg"
#define API_STR_ERROR @"false"
#define API_STR_TRUE @"true"

//设置APPID，用于提醒用户评价
#define U_APPID @"" //如果这写空字符就是不启用评价功能 770699556
//设置crashUrl，用于收集崩溃信息
#define U_CRASH_URL @"" //如果是空字符串则不收集错误 http://codeguesser.tk:804/crash_v300.php
//设置支付宝
#define U_SUPPORT_GPS YES

#define U_ALIPAY_PARTNER @"2088411419430159"//
#define U_ALIPAY_SELLER @"2055604618@qq.com"//
#define U_ALIPAY_PRIVATE_KEY @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMmE4PL4r5FRRag27sjelCMGv31wCGHN9XJXB6kBLRrnLnfdBt1rvnTRZ38NQCwFNdXu5TxDz8fJXE0Q+ruHdnfF96D7R9jcC6EDt0zqCy7Tk3bBfNR5HdswN7hrDp9HYNllsRmiOIg/RsnpELTzuomASeZlIN16/X9eOyQkryDbAgMBAAECgYAGrPMyuVA/lRyknOU+HDl2C5QuWJa+fq8h0YY8cACJgp0EdXrzvMz7W7B9AfhdPPLymk5Xt7tbV+1J1EUqDyu6bumlaab8wpt4O0qIQtc/tpXOsZxLEbkzfNQcA0YQ2LQ+I+XzWbbMLkbmRtTpJ3BthImiCKqRQo63qd8RHuQGyQJBAPVL1JixEW+IMTy1/ly1fodPikq7OrmLoBBcdodfZlnpwjeeWV0UnJBdPA4MeTYH2t4S4eXcKAbCIZTsr4WRhjUCQQDSUAURiDn4VksD4O6kCGMUyFAOKh0bZcBAGHm8wyLncNv38Cv4ASWwq++F+b2HCIgUGx8cgAe+/pzNlVNBeKzPAkEA5YnrTGNNzI+me4hWmUyhNV+iKmJgBqb4xravl+gW8AaF3uQH/ck+5PzKKN9VQdFB51PGHgHRVtms8R429YeDDQJBAIY7ZpDDFuTnBugJ16bAZ6TrGRWBUaSb8/G07XZKQevgP7VnCFk5Ojoh8zXaqVoXWusiSGAjY05HKgOZLFNcV0cCQEoCCUkrowBsx6Vq2nZx1EoTTb740+fqm4mxBBl6+nFyGghFHDMfJlw6OfzvtXD6Xsi/GbiX3Rf1PgiDLjtR9pU="//
//设置用户退出操作
#define M_GOLOGIN [self.navigationController.tabBarController presentViewController:CreateViewController(@"LoginViewController") animated:YES completion:^{}]
#endif