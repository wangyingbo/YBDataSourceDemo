//
//  YBTableViewController.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBTableViewController.h"

@interface YBTableViewController ()

@property (nonatomic, copy) Class _Nullable cellClass;

@end

@implementation YBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**初始化tableView*/
    [self createTableView];
    
    /**初始化DataSource*/
    [self initDatasource];

}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    _tableViewDS.tableData = dataArray;
}

- (void)initDatasourceWithCellClass:(Class)cellClass
{
    self.cellClass = cellClass;
    [self initDatasource];
}

/**
 *  创建tableView
 */
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}


- (void)initDatasource
{
    if (NSClassFromString(NSStringFromClass(self.cellClass))) {
        [self.tableView registerClass:self.cellClass forCellReuseIdentifier:@"yb_test_cell_id"];
    } else {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"yb_test_cell_id"];
    }
    
    __weak __typeof(&*self)weakSelf = self;
    self.tableViewDS = [[YBDataSource alloc] initWithTableData:self.dataArray cellIdentifier:@"yb_test_cell_id" cellForRowAtIndexPath:^(id cell, NSIndexPath *indexPath, id item) {
        
    }];
    
    
    [self.tableView setDataSource:self.tableViewDS];
    [self.tableView setDelegate:self.tableViewDS];
}

@end
