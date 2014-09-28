//
//  CGViewWithTableVIew.h
//  clubCard
//
//  Created by wang shuguan on 13-11-19.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "CGView.h"
#import "CGNothingView.h"

#import "ILoadView.h"
@interface CGViewWithTableVIew : CGView{
    CGNothingView *nothingView;
}
/**
 *  这是view里面套的一个tableview
 */
@property(nonatomic,strong)IBOutlet UITableView *tableView;
/**
 *  点击cell时触发事件的接收者
 */
@property(nonatomic,weak)IBOutlet id<ILoadData>delegate;
/**
 *  显示无数据界面
 */
-(void)showNothingView;
/**
 *  隐藏无数据界面
 */
-(void)hideNothingView;
@end
