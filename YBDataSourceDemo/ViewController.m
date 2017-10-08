//
//  ViewController.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "YBTestCell.h"
#import "YBListVC.h"
#import "YBCustomCell.h"


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
//    self.tableViewDS.cellForRowAtIndexPath = ^(id cell, NSIndexPath *indexPath, id item) {
//    };
    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
        return tableData.count;
    };
    self.tableViewDS.didSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath, id item) {
        YBListVC *listVC = [[YBListVC alloc]init];
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    };
    
    
#pragma mark - 方法二：使用自定义的tableViewCell
//    [self initDatasourceWithCellClass:[YBTestCell class] withCellIdentifier:@"cellId"];
//    //    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
//    //        YBTestCell *myCell = (YBTestCell *)cell;
//    //        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    //        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
//    //        myCell.contentLB.text = @"王颖博";
//    //    };
//    self.tableViewDS.cellForRowAtIndexPath = ^(id cell, NSIndexPath *indexPath, id item) {
//        YBTestCell *myCell = (YBTestCell *)cell;
//        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
//        myCell.contentLB.text = @"王颖博";
//    };
//    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
//        return tableData.count;
//    };
    
    
#pragma mark - 方法三：使用自定义的tableViewCell，可以使用多个不同的cell
//    NSArray *cellIDArr = @[@"testCellId",@"customCellId"];
//    [self configDatasourceWithCellClasses:@[[YBTestCell class],[YBCustomCell class]] withCellIdentifiers:cellIDArr];
//    self.tableViewDS = [[YBDataSource alloc]initWithTableData:self.dataArray cellsForRowAtIndexPath:^UITableViewCell *(NSIndexPath *indexPath, id item) {
//        if (indexPath.section == 0) {
//            YBTestCell *testCell = [YBTestCell cellWithTableView:self.tableView withIdentifier:cellIDArr[indexPath.section]];
//            testCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [testCell.iconImageView setImage:[UIImage imageNamed:@""]];
//            testCell.contentLB.text = @"王颖博";
//            return testCell;
//        }else {
//            YBCustomCell *customCell = (YBCustomCell *)[YBCustomCell cellWithTableView:self.tableView withIdentifier:cellIDArr[1]];
//            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [customCell.iconImageView setImage:[UIImage imageNamed:@""]];
//            customCell.contentLB.text = @"易点租";
//            return customCell;
//        }
//    }];
//    self.tableViewDS.cellsForRowShowAtIndexPath = ^void (id cell, NSIndexPath *indexPath, id item) {
//    };
//    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
//        return tableData.count;
//    };
//    [self configDatasource];
}


#pragma mark - 方法四：重写initDatasource方法-完成自定义
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
