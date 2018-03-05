//
//  PersonalCollectionViewCell.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/12.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "PersonalCollectionViewCell.h"
@interface PersonalCollectionViewCell()

@end

@implementation PersonalCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect myContentRect = CGRectInset(self.contentView.bounds, 1.0f, 1.0f);

        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
        myContentView.layer.borderWidth = 1.0f;
        [self.contentView addSubview:myContentView];
        
        _iconImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(35);
            make.height.width.equalTo(30);
        }];
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = BoldSystemFont(14);
        //_countLabel.textColor = RGB(15, 15, 15);
        [self.contentView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImage.right).inset(8);
            make.top.equalTo(_iconImage.top);
            make.width.equalTo(60);
            make.height.equalTo(16);
        }];
        
        _moduleLabel = [[UILabel alloc] init];
        _moduleLabel.font = BoldSystemFont(14);
        //_moduleLabel.textColor = RGB(15, 15, 15);
        [self.contentView addSubview:_moduleLabel];
        [_moduleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImage.right).inset(8);
            make.bottom.equalTo(_iconImage.bottom);
            make.width.equalTo(100);
            make.height.equalTo(16);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
