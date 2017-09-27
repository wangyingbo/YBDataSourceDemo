//
//  YBDataSource.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBDataSource.h"


@interface YBDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *cellClassName;
@property (nonatomic, copy) NSArray *cellIdentifierArray;

@end



@implementation YBDataSource

- (instancetype)initWithTableData:(NSArray *)tableData
                   cellIdentifier:(NSString *)cellIdentifier
            cellForRowAtIndexPath:(void (^)(id cell, NSIndexPath *indexPath, id item))cellForRowAtIndexPath
{
    self = [super init];
    
    if (self) {
        self.tableData = tableData;
        self.cellIdentifier = cellIdentifier;
        self.cellForRowAtIndexPath = cellForRowAtIndexPath;
        self.isAllowEdit = NO;
        _totalHeight = 0;
    }
    
    return self;
}

- (instancetype)initWithTableData:(NSArray *)tableData
           cellsForRowAtIndexPath:(UITableViewCell * (^)(NSIndexPath *indexPath, id item))cellsForRowAtIndexPath
{
    self = [super init];
    
    if (self) {
        self.tableData = tableData;
        self.cellsForRowAtIndexPath = cellsForRowAtIndexPath;
        self.isAllowEdit = NO;
        _totalHeight = 0;
    }
    
    return self;
}


#pragma mark -
#pragma mark - TableViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    _totalHeight = 0;
    
    if (self.numberOfSectionsInTableView) {
        return self.numberOfSectionsInTableView(self.tableData);
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        if (self.numberOfRowsInSection) {
            return self.numberOfRowsInSection(section, [self itemAtSection:section sectionKey:self.sectionKey]);
        } else if (self.numberOfSectionsInTableView) {
            NSArray *sectionArr = [self itemAtSection:section sectionKey:self.sectionKey];
            return [sectionArr count];
        } else {
            return [self.tableData count];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"\n exception:%@", NSStringFromSelector(_cmd));
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    id cellItem;
    
    
    if (self.cellsForRowAtIndexPath) {
       cellItem = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        cell = self.cellsForRowAtIndexPath(indexPath, cellItem);
        
        if (self.cellsForRowShowAtIndexPath) {
            self.cellsForRowShowAtIndexPath(cell, indexPath, cellItem);
        }
        return cell;
    }
    
    @try {
        if (!self.cellForIndexPath) {
            cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
            if (!cell) {
                cell = self.cellForIndexPath(indexPath);
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"\n exception:%@", NSStringFromSelector(_cmd));
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:self.cellIdentifier];
    }
    
    if (self.cellForRowAtCustom) {
        self.cellForRowAtCustom(cell, indexPath);
    } else if (self.cellForRowAtIndexPath) {
        cellItem = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        self.cellForRowAtIndexPath(cell, indexPath, cellItem);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellItem;
    
    if (self.cellWillDisplayAtIndexPath) {
        cellItem = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        self.cellWillDisplayAtIndexPath(cell, indexPath, cellItem);
    }
}

#pragma mark -
#pragma mark - TableViewDelegate
#pragma mark -
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id item = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:self.tableData];
        [mutArr removeObjectAtIndex:indexPath.row];
        self.tableData = mutArr;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (self.deleteRowAtIndexPath) {
            self.deleteRowAtIndexPath(indexPath, item);
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.canEditRowAtIndexPath) {
        id item = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        return self.canEditRowAtIndexPath(indexPath, item);
    }
    
    return self.isAllowEdit;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.titleForHeaderInSection) {
        return self.titleForHeaderInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.titleForFooterInSection) {
        return self.titleForFooterInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0;
    
    if (self.heightForRowAtIndexPath) {
        id item = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:nil];
        rowHeight =  self.heightForRowAtIndexPath(indexPath, item);
    } else {
        rowHeight =  tableView.rowHeight;
    }
    
    _totalHeight += rowHeight;
    
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (self.heightForHeaderInSection) {
        return self.heightForHeaderInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForFooterInSection) {
        return self.heightForFooterInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewForHeaderInSection) {
        return self.viewForHeaderInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.viewForFooterInSection) {
        return self.viewForFooterInSection(section, [self.tableData objectAtIndex:section]);
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellItem;
    
    if (!tableView.allowsMultipleSelection) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if (self.didSelectRowAtCustom) {
        self.didSelectRowAtCustom(indexPath);
    }
    else if (self.didSelectRowAtIndexPath) {
        cellItem = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:self.rowKey];
        self.didSelectRowAtIndexPath(indexPath, cellItem);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didDeselectRowAtIndexPath) {
        id cellItem;
        cellItem = [self itemAtIndexPath:indexPath sectionKey:self.sectionKey rowKey:self.rowKey];
        self.didDeselectRowAtIndexPath(indexPath, cellItem);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editingStyleForRowAtIndexPath) {
        return self.editingStyleForRowAtIndexPath(indexPath);
    } else if (self.isAllowEdit && tableView.allowsMultipleSelection) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.sectionIndexTitlesForTableView) {
        return self.sectionIndexTitlesForTableView();
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (id)itemAtSection:(NSInteger)section sectionKey:(NSString *)sectionKey
{
    id value;
    
    @try {
        if (self.numberOfSectionsInTableView) {
            if (sectionKey) {
                value = [self.tableData objectAtIndex:section][sectionKey];
            } else {
                value = [self.tableData objectAtIndex:section];
            }
        }
    }
    @catch (NSException *exception) {
        value = nil;
        NSLog(@"\n exception:%@", NSStringFromSelector(_cmd));
    }
    
    return value;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath sectionKey:(NSString *)sectionKey rowKey:(NSString *)rowKey
{
    if (!self.tableData.count) {
        return nil;
    }
    
    id value;
    
    @try {
        if (self.numberOfSectionsInTableView) {
            if (sectionKey && rowKey) {
                value = self.tableData[indexPath.section][sectionKey][indexPath.row][rowKey];
            } else if (sectionKey) {
                value = self.tableData[indexPath.section][sectionKey][indexPath.row];
            } else if (rowKey) {
                value = self.tableData[indexPath.section][indexPath.row][rowKey];
            } else {
                value = self.tableData[indexPath.section][indexPath.row];
            }
        } else if (rowKey) {
            value = self.tableData[indexPath.row][rowKey];
        } else {
            value = self.tableData[indexPath.row];
        }
    }
    @catch (NSException *exception) {
        value = nil;
        NSLog(@"\n exception:%@", NSStringFromSelector(_cmd));
    }
    
    return value;
}

@end
