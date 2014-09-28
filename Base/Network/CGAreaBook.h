//
//  CGAreaBook.h
//  Jinmaque
//
//  Created by Justin on 14/8/21.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WSGViewAreaProtocal <NSObject>
-(NSArray *)dataList;
-(NSString *)value;
@end
@interface CGAreaBookProvince : NSObject<WSGViewAreaProtocal>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSArray *citys;
@end
@interface CGAreaBookCity : NSObject<WSGViewAreaProtocal>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSArray *districts;
@end
@interface CGAreaBookDistrict : NSObject<WSGViewAreaProtocal>
@property(nonatomic,strong)NSString *name;
@end
@interface CGAreaBook : NSObject
+(NSArray *)getAreaBooks;
@end
