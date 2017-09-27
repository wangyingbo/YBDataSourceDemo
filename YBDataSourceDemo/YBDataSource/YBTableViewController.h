//
//  YBTableViewController.h
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBDataSource.h"

@interface YBTableViewController : UIViewController
{
    
}
@property (nonatomic, copy) NSArray * _Nullable dataArray;
@property (nonatomic, weak) UITableView * _Nullable tableView;
@property (nonatomic,strong) YBDataSource * _Nonnull tableViewDS;

#pragma mark - 自定义的cell(一步到位。具体参见demo里YBListVC里的用法)
- (void)initDatasourceWithCellClass:(_Nullable Class)cellClass withCellIdentifier:(NSString * _Nullable)cellIdentifier;


#pragma mark - 自定义(在下面两个方法中间调用cellForRow方法)
- (void)configDatasourceWithCellClass:(_Nullable Class)cellClass withCellIdentifier:(NSString *_Nullable)cellIdentifier;
- (void)configDatasource;

@end
