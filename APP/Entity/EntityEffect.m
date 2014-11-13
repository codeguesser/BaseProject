//
//  EntityEffect.m
//  Zhuangshi
//
//  Created by shuguan on 14-9-10.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "EntityEffect.h"

@implementation EntityEffect
+(EntityObject *)getObjectFromDic:(NSDictionary *)dic
{
    EntityEffect *t = [[[EntityEffect alloc] init] Init];
       t.width = [NSString stringWithFormat:@"%f",(SCREEN_WIDTH-10)/2.0f];
    t.height = [NSString stringWithFormat:@"%f",(SCREEN_WIDTH-10)/2.0f];;
    t.x = @"0";
    t.y = @"0";
    t.isUpdated = @"NO";
    t.Id = [dic objectForKey:@"id"];
    
    t.title = [dic objectForKey:@"title"];
    t.Channel_id = [dic objectForKey:@"channel_id"];
    t.Call_index = [dic objectForKey:@"call_index"];
    t.Link_url = [dic objectForKey:@"link_url"];
    t.Seo_title = [dic objectForKey:@"seo_title"];
    t.Seo_Keywords = [dic objectForKey:@"seo_keywords"];
    t.Seo_description = [dic objectForKey:@"seo_description"];
    t.url = [dic objectForKey:@"img_url"];
    t.Category_id = [dic objectForKey:@"category_id"];
    t.sort_id = [dic objectForKey:@"sort_id"];
    t.Click = [dic objectForKey:@"click"];
    t.status = [dic objectForKey:@"status"];
    t.Group_view = [dic objectForKey:@"groupids_view"];
    t.vote_id = [dic objectForKey:@"vote_id"];
    t.Is_msg = [dic objectForKey:@"is_msg"];
    t.Is_top = [dic objectForKey:@"is_top"];
    t.Is_red = [dic objectForKey:@"is_red"];
    t.Is_hot = [dic objectForKey:@"is_hot"];
    t.Is_slide = [dic objectForKey:@"is_slide"];
    t.Is_sys = [dic objectForKey:@"is_sys"];
    t.User_name = [dic objectForKey:@"user_name"];
    t.Add_time = [dic objectForKey:@"add_time"];
    t.Update_time = [dic objectForKey:@"update_time"];
    t.Xgt_apartment = [dic objectForKey:@"xgt_apartment"];
    return t;
}
+(NSArray *)arrFromArr:(NSArray *)_arr{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString *s in _arr) {
        [arr addObject:[EntityEffect getObjectFromDic:@{@"img_url":s}]];
//        [arr addObject:s.url];
    }
    return arr;
}
@end
