//
//  MyCardCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/15.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill | UIViewContentModeTop;
        _backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView.layer.cornerRadius = 5.0;
        //////
        _backgroundImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
        
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.backgroundColor = [UIColor grayColor];
        _shopImageView.layer.masksToBounds = YES;
        _shopImageView.layer.cornerRadius = 20.0;
        _shopImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_shopImageView];
        [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(5);
            make.height.width.equalTo(40);
        }];
        // 添加边框
        CALayer * layer = [_shopImageView layer];
        layer.borderColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 1.0f;
        
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = systemFont(12);
        _shopNameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_shopNameLabel];
        [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shopImageView.mas_right).inset(10);
            make.top.equalTo(10);
            make.width.equalTo(SCREEN_WIDTH - 60);
            make.height.equalTo(10);
        }];
        
        _cardNameLabel = [[UILabel alloc] init];
        _cardNameLabel.font = systemFont(24);
        _cardNameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_cardNameLabel];
        [_cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shopImageView.mas_right).inset(10);
            make.top.equalTo(_shopNameLabel.mas_bottom).equalTo(10);
            make.width.equalTo(SCREEN_WIDTH - 60);
            make.height.equalTo(28);
        }];
    }
    return self;
}

@end
