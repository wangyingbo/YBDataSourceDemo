//
//  UITableViewCell+YBCell.h
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/27.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (YBCell)
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
