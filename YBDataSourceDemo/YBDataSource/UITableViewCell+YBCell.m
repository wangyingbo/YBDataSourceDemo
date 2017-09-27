//
//  UITableViewCell+YBCell.m
//  YBDataSourceDemo
//
//  Created by 王迎博 on 2017/9/27.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "UITableViewCell+YBCell.h"

@implementation UITableViewCell (YBCell)

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    NSString *ID = identifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}
@end
