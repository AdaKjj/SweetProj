//
//  MainItemCell.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/19.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "MainItemCell.h"

#define FONT_LABEL systemFont(13)
@implementation MainItemCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _storeImageView = [[UIImageView alloc] init];
        _storeImageView.backgroundColor = COLOR_LIGHTXX_GRAY;
        _storeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _storeImageView.layer.cornerRadius = 3;
        _storeImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_storeImageView];
        [_storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(6);
            make.top.equalTo(0);
            make.height.equalTo(120);
            make.width.equalTo(180);
        }];
        
        _storNameLabel = [[UILabel alloc] init];
        _storNameLabel.font = FONT_LABEL;
        [self.contentView addSubview:_storNameLabel];
        [_storNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_storeImageView.mas_left);
            make.top.equalTo(_storeImageView.bottom);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
        
        _numOfCommentLabel = [[UILabel alloc] init];
        _numOfCommentLabel.font = FONT_LABEL;
        _numOfCommentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_numOfCommentLabel];
        [_numOfCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.top.equalTo(_storeImageView.bottom);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = FONT_LABEL;
        [self.contentView addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_storeImageView.mas_left);
            make.top.equalTo(_storNameLabel.bottom);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = FONT_LABEL;
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.textColor = RGB(189, 189, 189);
        [self.contentView addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.top.equalTo(_storNameLabel.bottom);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
