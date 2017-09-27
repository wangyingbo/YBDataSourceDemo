# YBDataSourceDemo

### 工具的主要目的是为了解决controller页面代码耦合度高问题。

+ 解决了vc里tableView的delegate和DataSource臃肿的问题；
+ 定义基类YBTableViewController，封装tableView以及它的代理方法；
+ 通过继承实现复用与解耦，使用简单方便；

### 使用方法

新建UIViewController继承自`YBTableViewController`,然后就可以通过以下三种方式调用：

+ 调用系统的UITableViewCell


		    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
		        cell.textLabel.text = @"name";
		    };
		//    self.tableViewDS.cellForRowAtIndexPath = ^(id cell, NSIndexPath *indexPath, id item) {
		//    };
		    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
		        return tableData.count;
		    };
		    self.tableViewDS.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath, id item) {
		        YBListVC *listVC = [[YBListVC alloc]init];
		        [weakSelf.navigationController pushViewController:listVC animated:YES];
		    };
	    
	    
+ 实现自定义的tableViewCell

		    [self initDatasourceWithCellClass:[YBTestCell class] withCellIdentifier:@"cellId"];
		    //    self.tableViewDS.cellWillDisplayAtIndexPath = ^(UITableViewCell *cell, NSIndexPath *indexPath, id item) {
		    //        YBTestCell *myCell = (YBTestCell *)cell;
		    //        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
		    //        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
		    //        myCell.contentLB.text = @"王颖博";
		    //    };
		    self.tableViewDS.cellForRowAtIndexPath = ^(id cell, NSIndexPath *indexPath, id item) {
		        YBTestCell *myCell = (YBTestCell *)cell;
		        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
		        [myCell.iconImageView setImage:[UIImage imageNamed:@""]];
		        myCell.contentLB.text = @"王颖博";
		    };
		    self.tableViewDS.numberOfSectionsInTableView = ^NSInteger(NSArray *tableData) {
		        return tableData.count;
		    };

+ 自定义的cell，可使用多个cell（自己调用setDelegate方法）

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

	    
+ 通过重写父类方法`- (void)initDatasource`调用

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
		    
		    self.tableViewDS.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath, id item) {
		        YBTestVC *testVC = [[YBTestVC alloc]init];
		        [weakSelf.navigationController pushViewController:testVC animated:YES];
		    };
		    
		    [self.tableView setDataSource:self.tableViewDS];
		    [self.tableView setDelegate:self.tableViewDS];
		}
		
### end