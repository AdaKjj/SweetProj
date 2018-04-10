//
//  FoodPreviewCell.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/27.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "FoodPreviewCell.h"
#import "UIImage+Addition.h"

@implementation FoodPreviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_topImageView];
        
        _storeNameLabel = [[UILabel alloc] init];
        [_storeNameLabel setFont:BoldSystemFont(25)];
        _storeNameLabel.textAlignment = NSTextAlignmentCenter;
        [_storeNameLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_storeNameLabel];
        [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(_topImageView.mas_bottom).inset(15);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(30);
        }];
        
        _introLabel = [[UILabel alloc] init];
        [_introLabel setFont:systemFont(18)];
        _introLabel.textAlignment = NSTextAlignmentCenter;
        [_introLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_introLabel];
        [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(_storeNameLabel.mas_bottom).inset(10);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(20);
        }];
        
        _bottomImageView2 = [[UIImageView alloc] init];
        _bottomImageView2.contentMode = UIViewContentModeScaleAspectFill;
        _bottomImageView2.layer.masksToBounds = YES;
        [self.contentView addSubview:_bottomImageView2];
        [_bottomImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(_introLabel.mas_bottom).equalTo(15);
            make.height.width.equalTo((SCREEN_WIDTH - 40)/3);
        }];
        
        _bottomImageView1 = [[UIImageView alloc] init];
        _bottomImageView1.contentMode = UIViewContentModeScaleAspectFill;
        _bottomImageView1.layer.masksToBounds = YES;
        [self.contentView addSubview:_bottomImageView1];
        [_bottomImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(_introLabel.mas_bottom).equalTo(15);
            make.height.width.equalTo((SCREEN_WIDTH - 40)/3);
        }];
        
        _bottomImageView3 = [[UIImageView alloc] init];
        _bottomImageView3.contentMode = UIViewContentModeScaleAspectFill;
        _bottomImageView3.layer.masksToBounds = YES;
        [self.contentView addSubview:_bottomImageView3];
        [_bottomImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.top.equalTo(_introLabel.mas_bottom).equalTo(15);
            make.height.width.equalTo((SCREEN_WIDTH - 40)/3);
        }];
        
        UIImage *seperateColor = [UIImage imageWithColor:RGB(77, 97, 40) size:CGSizeMake(SCREEN_WIDTH, 10)];
        UIImageView *seperate = [[UIImageView alloc]initWithImage:seperateColor];
        [self.contentView addSubview:seperate];
        [seperate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(15);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
