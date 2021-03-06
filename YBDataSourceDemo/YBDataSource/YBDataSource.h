//
//  YBDataSource.h
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YBDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *tableData;
@property (nonatomic, assign) BOOL isAllowEdit;
@property (nonatomic, copy) NSString *sectionKey;
@property (nonatomic, copy) NSString *rowKey;
@property (nonatomic, assign, readonly) CGFloat totalHeight;

@property (nonatomic, copy) UITableViewCell* (^cellForIndexPath)(NSIndexPath *indexPath);

//Number
@property (nonatomic, copy) NSInteger (^numberOfSectionsInTableView)(NSArray *tableData);
@property (nonatomic, copy) NSInteger (^numberOfRowsInSection)(NSInteger section, id item);
@property (nonatomic, copy) NSArray *(^sectionIndexTitlesForTableView)(void);

//Header
@property (nonatomic, copy) CGFloat (^heightForHeaderInSection)(NSInteger section, id item);
@property (nonatomic, copy) UIView *(^viewForHeaderInSection)(NSInteger section, id item);
@property (nonatomic, copy) NSString *(^titleForHeaderInSection)(NSInteger section, id item);

//Footer
@property (nonatomic, copy) CGFloat (^heightForFooterInSection)(NSInteger section, id item);
@property (nonatomic, copy) UIView *(^viewForFooterInSection)(NSInteger section, id item);
@property (nonatomic, copy) NSString *(^titleForFooterInSection)(NSInteger section, id item);

//edit, delete
@property (nonatomic, copy) UITableViewCellEditingStyle (^editingStyleForRowAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^deleteRowAtIndexPath)(NSIndexPath *indexPath, id item);
@property (nonatomic, copy) BOOL (^canEditRowAtIndexPath)(NSIndexPath *indexPath, id item);

//cellForRow, didSelect, height
@property (nonatomic, copy) void (^cellForRowAtCustom)(id cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^cellForRowAtIndexPath)(id cell, NSIndexPath *indexPath, id item);
@property (nonatomic, copy) UITableViewCell *(^cellsForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath,id item);
@property (nonatomic, copy) void (^cellsForRowShowAtIndexPath)(id cell ,NSIndexPath *indexPath,id item);
@property (nonatomic, copy) void (^cellWillDisplayAtIndexPath)(id cell, NSIndexPath *indexPath, id item);
@property (nonatomic, copy) void (^didSelectRowAtCustom)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath, id item);
@property (nonatomic, copy) void (^didDeselectRowAtIndexPath)(NSIndexPath *indexPath, id item);
@property (nonatomic, copy) CGFloat (^heightForRowAtIndexPath)(NSIndexPath *indexPath, id item);


- (instancetype)initWithTableData:(NSArray *)tableData
                   cellIdentifier:(NSString *)cellIdentifier
            cellForRowAtIndexPath:(void (^)(id cell, NSIndexPath *indexPath, id item))cellForRowAtIndexPath;

- (instancetype)initWithTableData:(NSArray *)tableData
            cellsForRowAtIndexPath:(UITableViewCell * (^)(UITableView *tableView,NSIndexPath *indexPath, id item))cellsForRowAtIndexPath;



@end
