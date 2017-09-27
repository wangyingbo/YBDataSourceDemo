//
//  YBListVC.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBListVC.h"
#import "YBTestCell.h"
#import "YBCustomCell.h"


@interface YBListVC ()

@end

@implementation YBListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@[@1,@2,@3],@[@1,@2]];
    
    
//    /**方法一*/
//    [self initDatasourceWithCellClass:[YBTestCell class] withCellIdentifier:@"cellId"];
////    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
////        YBTestCell *myCell = (YBTestCell *)cell;
////        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
////        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
////        myCell.contentLB.text = @"王颖博";
////    };
//    self.tableViewDS.cellForRowAtIndexPath = ^(id cell, NSIndexPath *indexPath, id item) {
//        YBTestCell *myCell = (YBTestCell *)cell;
//        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
//        myCell.contentLB.text = @"王颖博";
//    };
//    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
//        return tableData.count;
//    };
    
    
    /**方法二：使用自定义的tableViewCell，可以使用多个不同的cell*/
    NSArray *cellIDArr = @[@"testCellId",@"customCellId"];
    [self configDatasourceWithCellClasses:@[[YBTestCell class],[YBCustomCell class]] withCellIdentifiers:cellIDArr];
    self.tableViewDS = [[YBDataSource alloc]initWithTableData:self.dataArray cellsForRowAtIndexPath:^UITableViewCell *(NSIndexPath *indexPath, id item) {
        if (indexPath.section == 0) {
            YBTestCell *testCell = [YBTestCell cellWithTableView:self.tableView withIdentifier:cellIDArr[indexPath.section]];
            testCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [testCell.iconImageView setImage:[UIImage imageNamed:@""]];
            testCell.contentLB.text = @"王颖博";
            return testCell;
        }else {
            YBCustomCell *customCell = (YBCustomCell *)[YBCustomCell cellWithTableView:self.tableView withIdentifier:cellIDArr[1]];
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [customCell.iconImageView setImage:[UIImage imageNamed:@""]];
            customCell.contentLB.text = @"易点租";
            return customCell;
        }
    }];
    self.tableViewDS.cellsForRowShowAtIndexPath = ^void (id cell, NSIndexPath *indexPath, id item) {
    };
    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
        return tableData.count;
    };
    [self configDatasource];
    
    
    
    /**延迟模拟网络请求分页数据*/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = @[@[@1,@2,@3,@4,@5],@[@1,@2],@[@1,@2,@3]];
        [self.tableView reloadData];
    });
    
}



@end
