//
//  ViewController.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "YBTestCell.h"
#import "YBTestVC.h"
#import "YBListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.dataArray = @[@[@1,@2,@3],@[@1,@2]];
    
#pragma mark - 方法一：使用UITableViewCell
    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
        cell.textLabel.text = @"name";
    };
    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
        return tableData.count;
    };
    self.tableViewDS.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath, id item) {
        YBListVC *listVC = [[YBListVC alloc]init];
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    };
    
    
#pragma mark - 方法二：使用自定义的tableViewCell
//    [self initDatasourceWithCellClass:[YBTestCell class]];
//    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
//        YBTestCell *myCell = (YBTestCell *)cell;
//        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
//        myCell.contentLB.text = @"王颖博";
//    };
//    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
//        return tableData.count;
//    };
}


#pragma mark - 方法三：重写initDatasource方法
//- (void)initDatasource
//{
//    [self.tableView registerClass:[YBTestCell class] forCellReuseIdentifier:@"testCell"];
//    
//    __weak __typeof(&*self)weakSelf = self;
//    self.tableViewDS = [[YBDataSource alloc] initWithTableData:self.dataArray cellIdentifier:@"testCell" cellForRowAtIndexPath:^(id cell, NSIndexPath *indexPath, id item) {
//        
//        YBTestCell *myCell = (YBTestCell *)cell;
//        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
//        myCell.contentLB.text = @"王颖博";
//    }];
//    
//    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
//        return tableData.count;
//    };
//    
//    self.tableViewDS.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath, id item) {
//        YBTestVC *testVC = [[YBTestVC alloc]init];
//        [weakSelf.navigationController pushViewController:testVC animated:YES];
//    };
//    
//    [self.tableView setDataSource:self.tableViewDS];
//    [self.tableView setDelegate:self.tableViewDS];
//}


@end
