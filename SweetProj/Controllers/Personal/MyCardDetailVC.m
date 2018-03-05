//
//  MyCardDetailVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/16.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MyCardDetailVC.h"

@interface MyCardDetailVC ()

@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *shopImageView;

@property (nonatomic) UILabel *shopNameLbl;
@property (nonatomic) UILabel *vipLevel;
@property (nonatomic) UILabel *vipName;
@property (nonatomic) UILabel *vipNum;

@property (nonatomic) UILabel *scoreDetail;
@property (nonatomic) UILabel *levelDetail;
@property (nonatomic) UILabel *telDetail;

@end

@implementation MyCardDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.layer.cornerRadius = 20;
    _backgroundImageView.backgroundColor = self.color;
    [self.view addSubview:_backgroundImageView];
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(150);
    }];
    
    _shopImageView = [[UIImageView alloc] init];
    _shopImageView.layer.masksToBounds = YES;
    _shopImageView.layer.cornerRadius = 20;
    _shopImageView.image = _shopImage;
    [self.backgroundImageView addSubview:_shopImageView];
    [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(20);
        make.height.width.equalTo(40);
    }];
    
    _shopNameLbl = [[UILabel alloc] init];
    [_shopNameLbl setFont:BoldSystemFont(18)];
    [_shopNameLbl setTextColor:[UIColor whiteColor]];
    _shopNameLbl.text = _shopNameText;
    [self.backgroundImageView addSubview:_shopNameLbl];
    [_shopNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_right).inset(16);
        make.right.equalTo(_backgroundImageView.mas_right);
        make.height.equalTo(20);
        make.centerY.equalTo(_shopImageView.mas_centerY);
    }];
    
    _vipLevel = [[UILabel alloc] init];
    [_vipLevel setFont:systemFont(13)];
    [_vipLevel setTextColor:[UIColor whiteColor]];
    _vipLevel.text = @"VIP1";
    [self.backgroundImageView addSubview:_vipLevel];
    [_vipLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_left);
        make.right.equalTo(_shopImageView.mas_right);
        make.height.equalTo(15);
        make.top.equalTo(_shopImageView.mas_bottom).equalTo(20);
    }];
    
    _vipName = [[UILabel alloc] init];
    [_vipName setFont:systemFont(13)];
    [_vipName setTextColor:[UIColor whiteColor]];
    _vipName.text = @"会员用户";
    [self.backgroundImageView addSubview:_vipName];
    [_vipName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLbl.mas_left);
        make.width.equalTo(100);
        make.height.equalTo(15);
        make.top.equalTo(_shopImageView.mas_bottom).equalTo(20);
    }];
    
    _vipNum = [[UILabel alloc] init];
    [_vipNum setFont:systemFont(14)];
    [_vipNum setTextColor:[UIColor whiteColor]];
    _vipNum.text = @"2003 3432";
    [self.backgroundImageView addSubview:_vipNum];
    [_vipNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_left);
        make.width.equalTo(150);
        make.height.equalTo(16);
        make.top.equalTo(_vipName.mas_bottom).equalTo(20);
    }];
    
    [self setupDetail];
}

- (void)setupDetail {
    UIImageView *lineImageView1 = [[UIImageView alloc] init];
    lineImageView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineImageView1];
    [lineImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundImageView.mas_bottom).inset(20);
        make.width.equalTo(1);
        make.height.equalTo(50);
        make.left.equalTo((SCREEN_WIDTH - 2)/3);
    }];
    
    UIImageView *lineImageView2 = [[UIImageView alloc] init];
    lineImageView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineImageView2];
    [lineImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundImageView.mas_bottom).inset(20);
        make.width.equalTo(1);
        make.height.equalTo(50);
        make.right.equalTo(-(SCREEN_WIDTH - 2)/3);
    }];
    
    UILabel *scoreLabel = [[UILabel alloc] init];
    [scoreLabel setFont:systemFont(16)];
    scoreLabel.text = @"积分";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView1.mas_top);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.left.equalTo(0);
    }];
    
    _scoreDetail = [[UILabel alloc] init];
    [_scoreDetail setFont:systemFont(18)];
    _scoreDetail.text = @"27";
    _scoreDetail.textAlignment = NSTextAlignmentCenter;
    _scoreDetail.textColor = SYSTEMCOLOR;
    [self.view addSubview:_scoreDetail];
    [_scoreDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineImageView1.mas_bottom);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.left.equalTo(0);
    }];
    
    UILabel *levelLabel = [[UILabel alloc] init];
    [levelLabel setFont:systemFont(16)];
    levelLabel.text = @"等级";
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView1.mas_top);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.left.equalTo(lineImageView1.mas_right);
    }];
    
    _levelDetail = [[UILabel alloc] init];
    [_levelDetail setFont:systemFont(18)];
    _levelDetail.text = _vipLevel.text;
    _levelDetail.textAlignment = NSTextAlignmentCenter;
    _levelDetail.textColor = SYSTEMCOLOR;
    [self.view addSubview:_levelDetail];
    [_levelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineImageView1.mas_bottom);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.left.equalTo(lineImageView1.mas_right);
    }];
    
    UILabel *shopLabel = [[UILabel alloc] init];
    [shopLabel setFont:systemFont(16)];
    shopLabel.text = @"店铺详情";
    shopLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shopLabel];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView1.mas_top);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.right.equalTo(0);
    }];
    
    _levelDetail = [[UILabel alloc] init];
    [_levelDetail setFont:systemFont(18)];
    _levelDetail.text = @"查看";
    _levelDetail.textAlignment = NSTextAlignmentCenter;
    _levelDetail.textColor = SYSTEMCOLOR;
    [self.view addSubview:_levelDetail];
    [_levelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineImageView1.mas_bottom);
        make.width.equalTo((SCREEN_WIDTH - 2)/3);
        make.height.equalTo(20);
        make.right.equalTo(0);
    }];
    
    NSString *introText = @"本店会员消费满188元享8.8折哦！积分可以兑换礼品！会员生日当天进店消费有礼品赠送，会员优惠最终解释权归本店所有";
    //计算文本高度
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:introText
                                                                         attributes:@{NSFontAttributeName: systemFont(16)}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){SCREEN_WIDTH - 20*2, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    UILabel *intro = [[UILabel alloc] init];
    [intro setFont:systemFont(16)];
    intro.text = introText;
    intro.numberOfLines = 0;
    intro.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:intro];
    [intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView1.mas_bottom).inset(40);
        make.left.equalTo(20);
        make.height.equalTo(size.height);
        make.right.equalTo(-20);
    }];
    
    UILabel *tel = [[UILabel alloc] init];
    [tel setFont:systemFont(16)];
    tel.text = @"联系电话：";
    [self.view addSubview:tel];
    [tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intro.mas_bottom).inset(40);
        make.left.equalTo(20);
        make.height.equalTo(18);
        make.width.equalTo(80);
    }];
    
    _telDetail = [[UILabel alloc] init];
    [_telDetail setFont:systemFont(16)];
    _telDetail.textColor = SYSTEMCOLOR;
    _telDetail.text = @"13804289100";
    [self.view addSubview:_telDetail];
    [_telDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intro.mas_bottom).inset(40);
        make.left.equalTo(tel.mas_right);
        make.height.equalTo(18);
        make.width.equalTo(150);
    }];
    _telDetail.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_telDetail addGestureRecognizer:labelTapGestureRecognizer];
}

- (void)labelClick {
    //拨打电话
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_telDetail.text];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

@end
