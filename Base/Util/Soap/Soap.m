//
//  Soap.m
//  WANTTODIE
//
//  Created by Wangshuguan-mac on 13-7-3.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "Soap.h"
#import "XMLReader.h"
@implementation Soap
- (id)initWithDic:(NSDictionary *)dic key:(NSString *)key url:(NSString *)url
{
    self = [super init];
    if (self) {
        actionKey = key;
        actionUrl = url;
        soapMsg = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "%@"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[self strFromDic:dic]
                   ];
        [self getNetworkData];
    }
    return self;
}
-(NSString *)strFromDic:(NSDictionary *)dic{
    NSMutableString *appendStr = [NSMutableString new];
    for (NSString *key in [dic allKeys]) {
        [appendStr appendFormat:@"\n<%@%@>%@</%@>\n",key,([key isEqualToString:actionKey])?[NSString stringWithFormat:@" xmlns=\"%@\"",actionUrl]:@"",[[dic objectForKey:key] isKindOfClass:[NSDictionary class]]?[self strFromDic:[dic objectForKey:key]]:[dic objectForKey:key],key];
    }
    return appendStr;
}
- (NSString *)soapMsg{
    return soapMsg;
}
-(void)getNetworkData{
    NSURL *url = [NSURL URLWithString:WEBSEARVICE];
    // 根据上面的URL创建一个请求
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    req.timeoutInterval = 10;
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: @"http://tempuri.org/" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    // 设置请求行方法为POST，与请求报文第一行对应
    [req setHTTPMethod:@"POST"];
    // 将SOAP消息加到请求中
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    // 创建连接
    NSError *error;
    NSURLResponse *res;
    returnDic = [[[XMLReader dictionaryForXMLData:[NSURLConnection sendSynchronousRequest:req returningResponse:&res error:nil] error:&error] objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"];
}
- (NSDictionary *)returnDic{
    return returnDic;
}
@end
