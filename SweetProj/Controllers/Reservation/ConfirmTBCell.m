//
//  ConfirmTBCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/4/9.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ConfirmTBCell.h"
#import "ShopCarModel.h"

#define SPACING 15
#define WIDTH_PRICE 40
#define WIDTH_COUNT 35
#define WIDTH_NAME  100
@interface ConfirmTBCell ()
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *price;
@property (nonatomic) UILabel *count;
@end

@implementation ConfirmTBCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        _name = [[UILabel alloc] init];
        _name.font = systemFont(16);
        _name.textColor = CELL_TEXT_COLOR;
        _name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(SPACING + 5);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_NAME);
        }];
        
        _price = [[UILabel alloc] init];
        _price.font = systemFont(16);
        _price.textColor = CELL_TEXT_COLOR;
        _price.textAlignment = NSTextAlignmentRight;
        [self addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(- SPACING - 5);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_PRICE + 20);
        }];
        
        _count = [[UILabel alloc] init];
        _count.font = systemFont(16);
        _count.textColor = CELL_TEXT_COLOR;
        _count.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_count];
        [_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(_price.mas_left).inset(30 - 20);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_COUNT);
        }];
    }
    return self;
}

- (void)setModel:(ShopCarModel *)model {
    _model = model;
    
    _name.text = model.name;
    _price.text = [NSString stringWithFormat:@"%.2f",model.min_price];
    _count.text = [NSString stringWithFormat:@"%ld",model.count];
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


@implementation ConfirmTBHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalBg"]];
        self.backgroundView.alpha = 0;

        UILabel *seatTxt = [[UILabel alloc] init];
        seatTxt.font = BoldSystemFont(20);
        seatTxt.text = @"桌号 ：";
        seatTxt.textColor = CELL_TEXT_COLOR;
        [self addSubview:seatTxt];
        [seatTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(SPACING);
            make.height.equalTo(22);
            make.width.equalTo(100);
            make.top.equalTo(SPACING);
        }];
        
        _seat = [[UILabel alloc] init];
        _seat.font = systemFont(16);
        _seat.textColor = CELL_TEXT_COLOR;
        [self addSubview:_seat];
        [_seat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(seatTxt.mas_bottom).inset(5);
            make.left.equalTo(SPACING);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
        
        UILabel *name = [[UILabel alloc] init];
        name.font = systemFont(16);
        name.text = @"名称";
        name.textColor = CELL_TEXT_COLOR;
        name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(SPACING + 5);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_NAME);
            make.bottom.equalTo(-3);
        }];
        
        UILabel *price = [[UILabel alloc] init];
        price.font = systemFont(16);
        price.text = @"价格";
        price.textColor = CELL_TEXT_COLOR;
        price.textAlignment = NSTextAlignmentCenter;
        [self addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-SPACING - 5);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_PRICE);
            make.bottom.equalTo(-3);
        }];
        
        UILabel *count = [[UILabel alloc] init];
        count.font = systemFont(16);
        count.text = @"数量";
        count.textColor = CELL_TEXT_COLOR;
        count.textAlignment = NSTextAlignmentCenter;
        [self addSubview:count];
        [count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(price.mas_left).inset(30);
            make.height.equalTo(18);
            make.width.equalTo(WIDTH_COUNT);
            make.bottom.equalTo(-3);
        }];
        
        UIImageView *seperate = [[UIImageView alloc] init];
        seperate.backgroundColor = CELL_TEXT_COLOR;
        [self addSubview:seperate];
        [seperate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-1);
            make.left.equalTo(SPACING);
            make.right.equalTo(-SPACING);
            make.height.equalTo(1);
        }];
    }
    return self;
}

@end


@implementation ConfirmTBFooter

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalBg"]];
        self.backgroundView.alpha = 0;

        UIImageView *seperate = [[UIImageView alloc] init];
        seperate.backgroundColor = CELL_TEXT_COLOR;
        [self addSubview:seperate];
        [seperate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(SPACING);
            make.right.equalTo(-SPACING);
            make.height.equalTo(1);
        }];
        
        UILabel *priceLab = [[UILabel alloc] init];
        priceLab.font = BoldSystemFont(26);
        priceLab.text = @"总消费";
        priceLab.textAlignment = NSTextAlignmentRight;
        priceLab.textColor = CELL_TEXT_COLOR;
        [self addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-SPACING);
            make.height.equalTo(30);
            make.width.equalTo(120);
            make.top.equalTo(8);
        }];
        
        _price = [[UILabel alloc] init];
        _price.font = BoldSystemFont(26);
        _price.textColor = CELL_TEXT_COLOR;
        _price.textAlignment = NSTextAlignmentRight;
        [self addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLab.mas_bottom).inset(5);
            make.right.equalTo(-SPACING);
            make.width.equalTo(120);
            make.height.equalTo(30);
        }];
        
        _time = [[UILabel alloc] init];
        _time.font = systemFont(16);
        _time.textColor = CELL_TEXT_COLOR;
        [self addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(SPACING);
            make.height.equalTo(18);
            make.width.equalTo(200);
            make.top.equalTo(8);
        }];
    }
    return self;
}

@end
