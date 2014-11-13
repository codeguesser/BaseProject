//
//  TableViewController.h
//  Base
//
//  Created by rsaif on 14/11/12.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "ViewControllerImpl.h"
#import "CGTableView+loadView2.h"
@interface TableViewController : ViewControllerImpl{
    NSMutableArray *_dataList;
    __weak IBOutlet CGTableView_loadView2 *_tableView;
}

@end
