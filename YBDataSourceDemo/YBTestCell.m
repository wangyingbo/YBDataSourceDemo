//
//  YBTestCell.m
//  UITableView的封装
//
//  Created by 王迎博 on 2017/9/25.
//  Copyright © 2017年 YuanWei. All rights reserved.
//

#import "YBTestCell.h"

@implementation YBTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *contentLB = [[UILabel alloc]init];
    [self.contentView addSubview:contentLB];
    self.contentLB = contentLB;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(20, 0, self.contentView.frame.size.height, self.contentView.frame.size.height);
    self.contentLB.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+10, 0, self.frame.size.width/2, self.contentView.frame.size.height);
}

@end
