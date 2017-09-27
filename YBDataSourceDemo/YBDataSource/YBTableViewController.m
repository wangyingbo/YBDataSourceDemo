//
//  YBTableViewController.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBTableViewController.h"

@interface YBTableViewController ()

@property (nonatomic, copy) Class cellClass;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSArray *cellIdentifierArray;
@property (nonatomic, copy) NSArray<Class> *cellClassArray;

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



- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    _tableViewDS.tableData = dataArray;
}

#pragma mark - 自定义的cell，只能调willDisplay方法
- (void)initDatasourceWithCellClass:(Class)cellClass withCellIdentifier:(NSString * _Nullable)cellIdentifier
{
    if (cellIdentifier != nil && ![cellIdentifier isEqualToString:@""]) {
    }else {
        cellIdentifier = @"yb_test_cell_id";
    }
    self.cellIdentifier = cellIdentifier;
    self.cellClass = cellClass;
    [self initDatasource];
}

- (void)initDatasource
{
    if (self.cellIdentifier != nil && ![self.cellIdentifier isEqualToString:@""]) {
    }else {
        self.cellIdentifier = @"yb_test_cell_id";
    }
    
    if (NSClassFromString(NSStringFromClass(self.cellClass))) {
        [self.tableView registerClass:self.cellClass forCellReuseIdentifier:self.cellIdentifier];
    } else {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
    }
    
    __weak __typeof(&*self)weakSelf = self;
    self.tableViewDS = [[YBDataSource alloc] initWithTableData:self.dataArray cellIdentifier:self.cellIdentifier cellForRowAtIndexPath:^(id cell, NSIndexPath *indexPath, id item) {
        
    }];
    
    
    [self.tableView setDataSource:self.tableViewDS];
    [self.tableView setDelegate:self.tableViewDS];
}

#pragma mark - 自定义(在下面两个方法中间调用cellForRow方法)
- (void)configDatasourceWithCellClasses:(NSArray<Class> *)cellClasses withCellIdentifiers:(NSArray<NSString *> *)cellIdentifiers
{
    self.cellIdentifierArray = cellIdentifiers;
    self.cellClassArray = cellClasses;
    
    for (int i = 0; i<cellClasses.count; i++) {
        NSString *cellIdentifier;
        Class cellClass;
        @try {
            cellIdentifier = [cellIdentifiers objectAtIndex:i];
            cellClass = [cellClasses objectAtIndex:i];
        } @catch (NSException *exception) {
            NSLog(@"\n exception:%@", NSStringFromSelector(_cmd));
        } @finally {
            break;
        }
        
        if (cellIdentifier != nil && ![cellIdentifier isEqualToString:@""]) {
            cellIdentifier = cellIdentifier;
        }else {
            cellIdentifier = [NSString stringWithFormat:@"yb_test_cell_id_%d",i];
        }
        if (NSClassFromString(NSStringFromClass(cellClass))) {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
        } else {
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        }
    }
    
}

- (void)configDatasource
{
    [self.tableView setDataSource:self.tableViewDS];
    [self.tableView setDelegate:self.tableViewDS];
}



@end
