//
//  AdCell.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/20.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "AdCell.h"

@implementation AdCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.layer.masksToBounds = YES;
        _adImageView.layer.cornerRadius = 5;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.backgroundColor = COLOR_LIGHTXX_GRAY;
        [self.contentView addSubview:_adImageView];
        [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(0);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
