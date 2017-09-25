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

- (void)initDatasourceWithCellClass:(_Nullable Class)cellClass;

@end
