//
//  TableViewController.m
//  Base
//
//  Created by rsaif on 14/11/12.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "TableViewController.h"
#import "Cell.h"
@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataList = [NSMutableArray new];
    [_tableView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate for load view
-(void)loadMore{
    
}
-(void)refreshView{
    CGDataResult *h  = [[Service serviceWithRequest:[self createRequestWithPost:YES] ]getData];
    if (h.status.boolValue) {
        [_dataList removeAllObjects];
        [_dataList addObjectsFromArray:h.dataList];
    }
}


#pragma mark - delegateo for tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.data = @"asdfasdfaef";
    
    return cell;
}
@end
