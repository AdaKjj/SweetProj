//
//  MyCommentCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/14.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MyCommentCell.h"
#define BIANJU_L 15
#define BIANJU_S 10

#define HEIGHT_LBL 15

#define FONTL systemFont(16)
#define FONTM systemFont(14)
#define FONTS systemFont(12)

@implementation MyCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _name = [[UILabel alloc] init];
        [_name setFont:FONTL];
        [_name setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(BIANJU_L);
            make.top.equalTo(BIANJU_L);
            make.width.equalTo(100);
            make.height.equalTo(18);
        }];
        
        _money = [[UILabel alloc] init];
        [_money setFont:FONTS];
        [_money setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_money];
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(BIANJU_L);
            make.top.equalTo(_name.mas_bottom).inset(BIANJU_S);
            make.width.equalTo(100);
            make.height.equalTo(HEIGHT_LBL);
        }];
        
        _date = [[UILabel alloc] init];
        [_date setFont:FONTS];
        [_date setTextColor:COLOR_LIGHTXX_GRAY];
        [self.contentView addSubview:_date];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(BIANJU_L);
            make.top.equalTo(_money.mas_bottom).inset(BIANJU_S);
            make.width.equalTo(100);
            make.height.equalTo(HEIGHT_LBL);
        }];
        
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.contentMode = UIViewContentModeScaleAspectFill;
        _shopImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_shopImageView];
        [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-BIANJU_L);
            make.top.equalTo(BIANJU_L);
            make.bottom.equalTo(-BIANJU_L);
            make.width.equalTo(68);
        }];
        
        _state = [[UILabel alloc] init];
        [_state setFont:FONTM];
        _state.textAlignment = NSTextAlignmentRight;
        [_state setTextColor:RGB(178, 34, 34)];
        [self.contentView addSubview:_state];
        [_state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_shopImageView.mas_left).inset(BIANJU_L);
            make.top.equalTo(BIANJU_L);
            make.width.equalTo(100);
            make.height.equalTo(18);
        }];
        
        _apply = [UIButton buttonWithType:UIButtonTypeCustom];
        _apply.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_apply setTitle:@"申请售后" forState:UIControlStateNormal];
        [_apply.titleLabel setFont:FONTS];
        [_apply setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_apply];
        [_apply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_state.mas_bottom).inset(BIANJU_S);
            make.right.equalTo(_shopImageView.mas_left).inset(BIANJU_L);
            make.width.equalTo(100);
            make.height.equalTo(HEIGHT_LBL);
        }];
        
        _more = [UIButton buttonWithType:UIButtonTypeCustom];
        _more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_more setTitle:@"再来一单" forState:UIControlStateNormal];
        [_more.titleLabel setFont:FONTS];
        [_more setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_more];
        [_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_apply.mas_bottom).inset(BIANJU_S);
            make.right.equalTo(_shopImageView.mas_left).inset(BIANJU_L);
            make.width.equalTo(50);
            make.height.equalTo(HEIGHT_LBL);
        }];
        
        _time = [[UILabel alloc] init];
        [_time setFont:FONTS];
        _time.textAlignment = NSTextAlignmentRight;
        [_time setTextColor:COLOR_LIGHTXX_GRAY];
        [self.contentView addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_more.mas_left).inset(BIANJU_L);
            make.bottom.equalTo(-BIANJU_L);
            make.width.equalTo(50);
            make.height.equalTo(HEIGHT_LBL);
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

    // Configure the view for the selected state
}

@end
