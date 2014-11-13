//
//  EntityEffect.h
//  Zhuangshi
//
//  Created by shuguan on 14-9-10.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "EntityObject.h"

@interface EntityEffect : EntityObject
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *isUpdated;


@property(nonatomic,strong)NSString *width;
@property(nonatomic,strong)NSString *height;

@property(nonatomic,strong)NSString *x;
@property(nonatomic,strong)NSString *y;


@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *Channel_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *Call_index;
@property(nonatomic,strong)NSString *Img_url;
@property(nonatomic,strong)NSString *Class_list;
@property(nonatomic,strong)NSString *Add_time;
@property(nonatomic,strong)NSString *Category_id;;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *Link_url;
@property(nonatomic,strong)NSString *Seo_title;
@property(nonatomic,strong)NSString *Seo_Keywords;
@property(nonatomic,strong)NSString *Seo_description;
@property(nonatomic,strong)NSString *Group_view;
@property(nonatomic,strong)NSString *vote_id;
@property(nonatomic,strong)NSString *Is_msg;
@property(nonatomic,strong)NSString *Is_top;
@property(nonatomic,strong)NSString *Is_red;
@property(nonatomic,strong)NSString *Is_hot;
@property(nonatomic,strong)NSString *Is_slide;
@property(nonatomic,strong)NSString *Content;
@property(nonatomic,strong)NSString *sort_id;
@property(nonatomic,strong)NSString *Click;
@property(nonatomic,strong)NSString *Is_sys;
@property(nonatomic,strong)NSString *User_name;
@property(nonatomic,strong)NSString *Update_time;
@property(nonatomic,strong)NSString *Xgt_apartment;
@property(nonatomic,strong)UIImage *img;
+(id)dataWithUrl:(NSString *)url;
+(NSArray *)arrFromArr:(NSArray *)arr;
@end
