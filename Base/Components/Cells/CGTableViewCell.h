//
//  CGTableViewCell.h
//  contact
//
//  Created by wang shuguan on 13-12-3.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGTableViewCell : UITableViewCell
/**
 *  传递的data，必须是实体类，也就是EnityObject的子类或者它本身
 */
@property(nonatomic,strong)id data;
/**
 *  indexPath，可以从table传递过来，当然这货再删除或者更改结构时就不可用了，因为没人刷新，请留意
 */
@property(nonatomic,strong)NSIndexPath *indexPath;
/**
 *  所有的组件都需要初始化
 */
-(void)Init;
/**
 *  获取内容大小，其实已经废弃了，还是手动算比较好，因为它往往在视图加载之前就需要了
 *
 *  @return 内容大小的size
 */
-(CGSize)getContentSize __deprecated;
@end
