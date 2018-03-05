//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "RightTableViewCell.h"
#import "CategoryModel.h"


@interface RightTableViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic) int count;

@property (nonatomic) UILabel *countLabel;

@end

@implementation RightTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        [self.contentView addSubview:self.imageV];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 5, 200, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 50, 100, 20)];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = RGB(158, 202, 35);
        [self.contentView addSubview:self.priceLabel];
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.text = @"评论数：500";
        self.commentLabel.font = systemFont(11);
        self.commentLabel.textColor = RGB(215, 215, 215);
        [self.contentView addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).inset(5);
            make.left.equalTo(self.nameLabel.mas_left);
            make.width.equalTo(100);
            make.height.equalTo(15);
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
            make.left.equalTo(260);
            make.bottom.equalTo(self.priceLabel.mas_bottom);
            make.height.equalTo(20);
            make.width.equalTo(20);
        }];
        
        _count = 0;
        
        _countLabel = [[UILabel alloc] init];
        self.countLabel.text = [NSString stringWithFormat:@"%d",_count];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = systemFont(14);
        self.countLabel.backgroundColor = [UIColor lightGrayColor];
        self.countLabel.layer.masksToBounds = YES;
        self.countLabel.layer.cornerRadius = 10;
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_addBtn.mas_top);
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
            make.bottom.equalTo(self.priceLabel.mas_bottom);
            make.height.equalTo(20);
            make.width.equalTo(20);
        }];
        
    }
    return self;
}

- (void)clickPuls:(UIButton *)btn
{
    self.count += 1;
    self.countLabel.text = [NSString stringWithFormat:@"%d",_count];
    self.operationBlock(self.count,NO);
}
- (void)clickMin:(UIButton *)btn
{
    if (_count > 0) {
        self.count -= 1;
        self.countLabel.text = [NSString stringWithFormat:@"%d",_count];
        self.operationBlock(self.count,NO);

    }
}

- (void)setModel:(FoodModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(model.min_price)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
