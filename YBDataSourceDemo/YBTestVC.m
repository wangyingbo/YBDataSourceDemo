//
//  YBTestVC.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBTestVC.h"
#import "YBDataSource.h"
#import "YBTestCell.h"

@interface YBTestVC ()

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic,strong) YBDataSource *tableViewDS;

@end

@implementation YBTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@[@1,@2,@3],@[@1,@2]];
    
    /**初始化tableView*/
    [self createTableView];
    
    /**初始化DataSource*/
    [self initDatasource];
    
    /**延迟模拟网络请求分页数据*/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = @[@[@1,@2,@3,@4,@5],@[@1,@2],@[@1,@2,@3]];
        self.tableViewDS.tableData = self.dataArray;
        [self.tableView reloadData];
    });
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
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}


- (void)initDatasource
{
    [self.tableView registerClass:[YBTestCell class] forCellReuseIdentifier:@"testCell"];
    
    __weak __typeof(&*self)weakSelf = self;
    self.tableViewDS = [[YBDataSource alloc] initWithTableData:self.dataArray cellIdentifier:@"testCell" cellForRowAtIndexPath:^(id cell, NSIndexPath *indexPath, id item) {
        
        YBTestCell *myCell = (YBTestCell *)cell;
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
        myCell.contentLB.text = @"王颖博";
    }];
    
    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
        return tableData.count;
    };
    
    self.tableViewDS.numberOfRowsInSection = ^NSInteger(NSInteger section, id item) {
        NSArray *arr = [weakSelf.dataArray objectAtIndex:section];
        return arr.count;
    };
    
    self.tableViewDS.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"点击了第%ld个section的第%ld个cell",indexPath.section,indexPath.row);
    };
    
    [self.tableView setDataSource:self.tableViewDS];
    [self.tableView setDelegate:self.tableViewDS];
}

@end
