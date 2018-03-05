//
//  RightCollectionViewCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/2/22.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "RightCollectionViewCell.h"

@implementation RightCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(250);
            make.width.equalTo(200);
        }];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)]; // UIRectCornerBottomRight通过这个设置
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = _imageView.bounds;
        maskLayer.path = maskPath.CGPath;
        _imageView.layer.mask = maskLayer;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
