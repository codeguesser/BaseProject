//
//  HomeDetailViewController.m
//  Base
//
//  Created by Justin on 14/8/28.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
@import MapKit;
@import CoreLocation;
@interface HomeDetailViewController ()
//<CLLocationManagerDelegate,MKMapViewDelegate>
{
    
//    __weak IBOutlet MKMapView *_mapView;
//    CLLocationManager *locationManager;
}

@end
@interface MYAnnotation:NSObject< MKAnnotation >
+(id)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subTitle:(NSString *)subTitle;
@end
@implementation MYAnnotation
@synthesize coordinate,title,subtitle;
+(id)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subTitle:(NSString *)subTitle{
    MYAnnotation *n = [[MYAnnotation alloc] initWithTitle:title subTitle:subTitle coordinate:coordinate];
    return n;
}
-(id)initWithTitle:(NSString *)t subTitle:(NSString *)stitle coordinate:(CLLocationCoordinate2D)c{
    self = [super init];
    if (self) {
        title = t;
        subtitle = stitle;
        coordinate = c;
    }
    return self;
}
@end
@implementation HomeDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self performSelector:@selector(payAction) withObject:nil afterDelay:1.3f];
    
    
    [self showAnimated:YES title:@"" whileExecutingBlock:^CGDataResult *(ASIHTTPRequest *request) {
        Service * s = [Service serviceWithRequest:request];
        s.coding = kCFStringEncodingGB_18030_2000;
        return [s getData];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if (b) {
            //
        }
    }];
    
    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = 1000;
//    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//    [locationManager startUpdatingLocation];
//    _mapView.showsUserLocation = YES;
}
//-(void)dealloc{
//    [locationManager stopUpdatingLocation];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    if (locations.count>0) {
//        CLLocation *l = locations[0];
//        URLLog(@"%f,%f",l.coordinate.latitude,l.coordinate.longitude);
//        [_mapView setCenterCoordinate:l.coordinate animated:YES];
//        [_mapView setRegion:MKCoordinateRegionMakeWithDistance(l.coordinate, 1000, 1000)];
//        [_mapView addAnnotation:[MYAnnotation annotationWithCoordinate:l.coordinate title:@"teset" subTitle:@"adsf"]];
//    }
//}
//#pragma mark - MKMapViewDelegate
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    // 重用
//    MKPinAnnotationView* pinView = (MKPinAnnotationView*)\
//    [mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
//    if (pinView == nil)
//    {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//                                                  reuseIdentifier:@"ID"];
//    }
//    
//    //能显示Call信息上面那些图字(很重要哦)
//    pinView.canShowCallout = YES;
//    
//    //只有三种
//    pinView.pinColor = MKPinAnnotationColorPurple;
//    
//    //显示动画 - 从天上落下
//    pinView.animatesDrop = YES;
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    pinView.rightCalloutAccessoryView = button;
//    return pinView;
//}

#pragma mark - payment
-(void)payAction{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
/*============================================================================*/
/*=======================需要填写商户app申请的===================================*/
/*============================================================================*/
    NSString *partner = U_ALIPAY_PARTNER;
    NSString *seller = U_ALIPAY_SELLER;
    NSString *privateKey = U_ALIPAY_PRIVATE_KEY;
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = PROJECT_URL;
/*============================================================================*/
/*============================================================================*/
/*============================================================================*/
    
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = @"myorderid"; //订单ID（由商家自行制定）
    order.productName = @"标题"; //商品标题
    order.productDescription = @"描述"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",11.00]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
    }
}


@end
