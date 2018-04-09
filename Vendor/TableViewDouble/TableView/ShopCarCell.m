//
//  ShopCarCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/28.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ShopCarCell.h"
#import "UIControl+hitTest.h"

@implementation ShopCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _name = [[UILabel alloc] init];
        [_name setFont:systemFont(15)];
        [_name setTextColor:CELL_TEXT_COLOR];
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.width.equalTo(160);
            make.height.equalTo(20);
        }];
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.layer.masksToBounds = YES;
        _addBtn.layer.cornerRadius = 10;
        _addBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.addBtn.layer.borderWidth = 1.0f;
        _addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _addBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_addBtn addTarget:self action:@selector(clickPuls:) forControlEvents:UIControlEventTouchUpInside];
        [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
        [self.contentView addSubview:self.addBtn];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(0);
            make.height.equalTo(20);
            make.width.equalTo(20);
        }];
        [_addBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
        
        _count = 0;
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = [NSString stringWithFormat:@"%d",_count];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = systemFont(15);
        [self.contentView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(_addBtn.mas_left).inset(4);
            make.width.equalTo(30);
            make.height.equalTo(20);
        }];
        
        _minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minBtn.layer.masksToBounds = YES;
        _minBtn.layer.cornerRadius = 10;
        _minBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.minBtn.layer.borderWidth = 1.0f;
        _minBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _minBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_minBtn addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
        [self.minBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.minBtn setTitle:@"-" forState:UIControlStateNormal];
        [self.contentView addSubview:self.minBtn];
        [self.minBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_countLabel.mas_left).inset(4);
            make.centerY.equalTo(0);
            make.height.equalTo(20);
            make.width.equalTo(20);
        }];
        [_minBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
        
        _price = [[UILabel alloc] init];
        [_price setFont:systemFont(15)];
        [_price setTextColor:CELL_TEXT_COLOR];
        _price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_minBtn.mas_left).inset(20);
            make.centerY.equalTo(0);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
    }
    return self;
}

- (void)clickPuls:(UIButton *)btn
{
    int count = [_countLabel.text intValue];
    count++;
    self.countLabel.text = [NSString stringWithFormat:@"%d",count];
    self.operationBlock(self.indexPath,YES);
}
- (void)clickMin:(UIButton *)btn
{
    int count = [_countLabel.text intValue];
    if (count > 0) {
        count--;
        self.countLabel.text = [NSString stringWithFormat:@"%d",count];
        self.operationBlock(self.indexPath,NO);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
