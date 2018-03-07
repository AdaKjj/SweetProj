//
//  FoodDetailVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/27.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "FoodDetailVC.h"
#import "UIImage+Addition.h"
#import "ReservationInfoVC.h"
#import <QMapKit/QMapKit.h>
#import "TopicTableViewCell.h"
#import "TggStarEvaluationView.h"
#import "SelectionVC.h"
#import "XWScanImage.h"

#define BIANJU  22
@interface FoodDetailVC ()<QMapViewDelegate> {
    NSArray *_ImageArr;

}

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *topImageView;

@property (nonatomic) UIButton *backBtn;

@property (nonatomic) UILabel *storeLabel;
@property (nonatomic) UILabel *introLabel;
@property (nonatomic) UILabel *bussinessHourLabel;
@property (nonatomic) UILabel *consumptionLabel;

@property (nonatomic) UILabel *detailLabel;

@property (nonatomic) UIButton *moreFoodBtn;
@property (nonatomic) UIImageView *moreFoodImageView1;
@property (nonatomic) UIImageView *moreFoodImageView2;
@property (nonatomic) UIImageView *moreFoodImageView3;

@property (nonatomic) UIButton *morePhotoBtn;
@property (nonatomic) UIImageView *morePhotoImageView1;
@property (nonatomic) UIImageView *morePhotoImageView2;
@property (nonatomic) UIImageView *morePhotoImageView3;



@property (nonatomic) UIImageView *appointmentToolBar;
@property (nonatomic) UIButton *appointmentBtn;
@property (nonatomic) UILabel *payLabel;
@property (nonatomic) UIButton *telBtn;
@property (nonatomic) TggStarEvaluationView *tggStarEvaView;


@property (nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic) UIButton *currentLocBtn;

@property (nonatomic) UITableView *photoTableView;

@property (nonatomic) CGFloat cellHeight;


@end

@implementation FoodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"店铺介绍";
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.userInteractionEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(-60);
    }];
    
    
    
    [self setupScrollView];
    [self setupMapDetail];
    [self setupArr];
    [self setupDetail];
    
    [self configAppointmentToolBar];
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_morePhotoImageView1 addGestureRecognizer:tapGestureRecognizer1];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_morePhotoImageView2 addGestureRecognizer:tapGestureRecognizer2];
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_morePhotoImageView3 addGestureRecognizer:tapGestureRecognizer3];
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_moreFoodImageView1 addGestureRecognizer:tapGestureRecognizer4];
    UITapGestureRecognizer *tapGestureRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_moreFoodImageView2 addGestureRecognizer:tapGestureRecognizer5];
    UITapGestureRecognizer *tapGestureRecognizer6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_moreFoodImageView3 addGestureRecognizer:tapGestureRecognizer6];
}



- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(doubleRes)
               name:@"doubleRes"
             object:nil];
    [nc addObserver:self
           selector:@selector(seatRes)
               name:@"seatRes"
             object:nil];
    [nc addObserver:self
           selector:@selector(singleRes)
               name:@"singleRes"
             object:nil];
}
- (void)dealloc {
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)doubleRes {
    
}

- (void)seatRes {
    
}

- (void)singleRes {
    ReservationInfoVC *reVC = [[ReservationInfoVC alloc] init];
    [self.navigationController pushViewController:reVC animated:YES];
}

- (void)setupScrollView {
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.image = _topImage;
    [_scrollView addSubview:_topImageView];
    _topImageView.userInteractionEnabled = YES;
    
    UIImage *round = [UIImage ellipseImageOfSize:CGSizeMake(40, 40) color:RGBA(50, 50, 50, 0.5)];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [_backBtn setBackgroundImage:round forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(onTouchBack) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(20);
        make.width.and.height.equalTo(40);
    }];
    
    _storeLabel = [[UILabel alloc] init];
    [_storeLabel setFont:BoldSystemFont(25)];
    _storeLabel.text = _storeString;
    _storeLabel.textAlignment = NSTextAlignmentCenter;
    [_storeLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:_storeLabel];
    [_storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_topImageView.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(28);
    }];
    
    _introLabel = [[UILabel alloc] init];
    [_introLabel setFont:systemFont(15)];
    _introLabel.text = @"店铺介绍";
    _introLabel.textAlignment = NSTextAlignmentCenter;
    [_introLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:_introLabel];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_storeLabel.mas_bottom).inset(10);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    _bussinessHourLabel = [[UILabel alloc] init];
    [_bussinessHourLabel setFont:systemFont(15)];
    _bussinessHourLabel.text = @"营业时间： 8:00 - 23:00";
    _bussinessHourLabel.textAlignment = NSTextAlignmentCenter;
    [_bussinessHourLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:_bussinessHourLabel];
    [_bussinessHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_introLabel.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    _consumptionLabel = [[UILabel alloc] init];
    [_consumptionLabel setFont:systemFont(15)];
    _consumptionLabel.text = @"人均消费： 60 元";
    _consumptionLabel.textAlignment = NSTextAlignmentCenter;
    [_consumptionLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:_consumptionLabel];
    [_consumptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_bussinessHourLabel.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    //计算文本高度
    NSString *detailText = @"软件一共分为三个基本模块。第一、浏览店铺后预定及点餐功能。顾客可以在选择喜欢的店铺后根据可预定时间范围以及剩余座位数量进行预订并下订单。其中订单结算可以分为自行结算，AA制以及一人付清的方式。第二、“话题”功能。顾客可以在该模块中发送图片及文字（类似朋友圈）。第三、个人模块。该模块包括6个小单元：个人信息、会员卡及优惠卷、我的预定、我的收藏和历史订单。";
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:detailText
                                                                         attributes:@{NSFontAttributeName: systemFont(15)}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){SCREEN_WIDTH - BIANJU*2, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setFont:systemFont(15)];
    _detailLabel.numberOfLines = 0;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _detailLabel.text = detailText;
    [self.scrollView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_consumptionLabel.mas_bottom).inset(20);
        make.width.equalTo(SCREEN_WIDTH - BIANJU*2);
        make.height.equalTo(size.height);
    }];
    
    //————————————————————————————————————推荐美食
    UIImage *whiteImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 22)];
    UIImageView *recommendedFoodToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    recommendedFoodToolBar.userInteractionEnabled = YES;
    [self.scrollView addSubview:recommendedFoodToolBar];
    [recommendedFoodToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailLabel.mas_bottom).inset(20);
        make.left.equalTo(0);
        make.height.equalTo(18);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *recommendedFood = [[UILabel alloc]init];
    recommendedFood.text = @"推荐美食";
    recommendedFood.textColor = [UIColor blackColor];
    [recommendedFood setFont:systemFont(16)];
    [recommendedFoodToolBar addSubview:recommendedFood];
    [recommendedFood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(BIANJU);
        make.width.equalTo(100);
        make.height.equalTo(18);
    }];
    
    _moreFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreFoodBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [_moreFoodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreFoodBtn.titleLabel setFont:systemFont(14)];
    _moreFoodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight & UIControlContentVerticalAlignmentBottom;
    [_moreFoodBtn addTarget:self action:@selector(moreFoodBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [recommendedFoodToolBar addSubview:_moreFoodBtn];
    [_moreFoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(-BIANJU);
        make.width.equalTo(150);
        make.height.equalTo(18);
    }];
    
    _moreFoodImageView2 = [[UIImageView alloc] init];
    _moreFoodImageView2.contentMode = UIViewContentModeScaleAspectFill;
    _moreFoodImageView2.layer.masksToBounds = YES;
    _moreFoodImageView2.userInteractionEnabled = YES;
    [self.scrollView addSubview:_moreFoodImageView2];
    [_moreFoodImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    
    _moreFoodImageView1 = [[UIImageView alloc] init];
    _moreFoodImageView1.contentMode = UIViewContentModeScaleAspectFill;
    _moreFoodImageView1.layer.masksToBounds = YES;
    _moreFoodImageView1.userInteractionEnabled = YES;
    [self.scrollView addSubview:_moreFoodImageView1];
    [_moreFoodImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BIANJU);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    _moreFoodImageView3 = [[UIImageView alloc] init];
    _moreFoodImageView3.contentMode = UIViewContentModeScaleAspectFill;
    _moreFoodImageView3.layer.masksToBounds = YES;
    _moreFoodImageView3.userInteractionEnabled = YES;
    [self.scrollView addSubview:_moreFoodImageView3];
    [_moreFoodImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moreFoodImageView2.mas_right).inset(15);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    //————————————————————————————————————更多照片导航栏
    UIImageView *morePhotoToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    morePhotoToolBar.userInteractionEnabled = YES;
    [self.scrollView addSubview:morePhotoToolBar];
    [morePhotoToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moreFoodImageView2.mas_bottom).inset(15);
        make.left.equalTo(0);
        make.height.equalTo(22);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *morePhotoLabel = [[UILabel alloc]init];
    morePhotoLabel.text = @"店内环境";
    morePhotoLabel.textColor = [UIColor blackColor];
    [morePhotoLabel setFont:systemFont(16)];
    [morePhotoToolBar addSubview:morePhotoLabel];
    [morePhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(BIANJU);
        make.width.equalTo(100);
        make.height.equalTo(18);
    }];
    
    _morePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_morePhotoBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [_morePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_morePhotoBtn.titleLabel setFont:systemFont(14)];
    _morePhotoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight & UIControlContentVerticalAlignmentBottom;
    [_morePhotoBtn addTarget:self action:@selector(morePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [morePhotoToolBar addSubview:_morePhotoBtn];
    [_morePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(-BIANJU);
        make.width.equalTo(150);
        make.height.equalTo(18);
    }];
    
    _morePhotoImageView2 = [[UIImageView alloc] init];
    _morePhotoImageView2.contentMode = UIViewContentModeScaleAspectFill;
    _morePhotoImageView2.layer.masksToBounds = YES;
    _morePhotoImageView2.userInteractionEnabled = YES;
    [self.scrollView addSubview:_morePhotoImageView2];
    [_morePhotoImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    _morePhotoImageView1 = [[UIImageView alloc] init];
    _morePhotoImageView1.contentMode = UIViewContentModeScaleAspectFill;
    _morePhotoImageView1.layer.masksToBounds = YES;
    _morePhotoImageView1.userInteractionEnabled = YES;
    [self.scrollView addSubview:_morePhotoImageView1];
    [_morePhotoImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BIANJU);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    _morePhotoImageView3 = [[UIImageView alloc] init];
    _morePhotoImageView3.contentMode = UIViewContentModeScaleAspectFill;
    _morePhotoImageView3.layer.masksToBounds = YES;
    _morePhotoImageView3.userInteractionEnabled = YES;
    [self.scrollView addSubview:_morePhotoImageView3];
    [_morePhotoImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_morePhotoImageView2.mas_right).inset(15);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    UIImage *lineImage = [UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(SCREEN_WIDTH - BIANJU*2, 3.0)];
    UIImageView *lineImageView = [[UIImageView alloc]initWithImage:lineImage];
    [self.scrollView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_morePhotoImageView1.bottom).inset(35);
        make.left.equalTo(BIANJU);
        make.height.equalTo(3);
        make.width.equalTo(SCREEN_WIDTH - BIANJU*2);
    }];
    
    UILabel *mapLabel = [[UILabel alloc] init];
    mapLabel.text = @"地图";
    mapLabel.textColor = [UIColor blackColor];
    mapLabel.textAlignment = NSTextAlignmentCenter;
    mapLabel.backgroundColor = [UIColor whiteColor];
    [mapLabel setFont:systemFont(18)];
    [self.scrollView addSubview:mapLabel];
    [mapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lineImageView.mas_centerX);
        make.centerY.equalTo(lineImageView.mas_centerY);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    //地图
    self.mapView = [[QMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mapLabel.mas_bottom).inset(10);
        make.left.equalTo(BIANJU);
        make.right.equalTo(-BIANJU);
        make.height.equalTo((SCREEN_WIDTH - BIANJU*2)*3/4);
    }];
    _mapView.userInteractionEnabled = YES;
    _mapView.delegate=self;
    
    _currentLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _currentLocBtn.userInteractionEnabled = YES;
    [_currentLocBtn setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [_currentLocBtn setImage:[UIImage imageNamed:@"map_select"] forState:UIControlStateHighlighted];
    [_currentLocBtn addTarget:self action:@selector(currentLocBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:_currentLocBtn];
    [_currentLocBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.bottom.equalTo(_mapView.mas_bottom).inset(5);
        make.right.equalTo(_mapView.mas_right).inset(5);
    }];
    
    //圈子
    UIImageView *lineImageView2 = [[UIImageView alloc]initWithImage:lineImage];
    [self.scrollView addSubview:lineImageView2];
    [lineImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mapView.bottom).inset(30);
        make.left.equalTo(BIANJU);
        make.height.equalTo(3);
        make.width.equalTo(SCREEN_WIDTH - BIANJU*2);
    }];
    
    UILabel *circleLabel = [[UILabel alloc] init];
    circleLabel.text = @"圈子";
    circleLabel.textColor = [UIColor blackColor];
    circleLabel.textAlignment = NSTextAlignmentCenter;
    circleLabel.backgroundColor = [UIColor whiteColor];
    [circleLabel setFont:systemFont(18)];
    [self.scrollView addSubview:circleLabel];
    [circleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lineImageView2.mas_centerX);
        make.centerY.equalTo(lineImageView2.mas_centerY);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1300);
}

- (void)setupDetail {
    _moreFoodImageView1.image = [_ImageArr objectAtIndex:0];
    _moreFoodImageView2.image = [_ImageArr objectAtIndex:1];
    _moreFoodImageView3.image = [_ImageArr objectAtIndex:2];
    
    _morePhotoImageView1.image = [_ImageArr objectAtIndex:0];
    _morePhotoImageView2.image = [_ImageArr objectAtIndex:1];
    _morePhotoImageView3.image = [_ImageArr objectAtIndex:2];
}

-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

- (void)setupArr {
    _ImageArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"text1"], [UIImage imageNamed:@"text2"], [UIImage imageNamed:@"text3"], nil];
}

- (void)configAppointmentToolBar {
    _appointmentToolBar = [[UIImageView alloc]init];
    _appointmentToolBar.backgroundColor = [UIColor whiteColor];
    _appointmentToolBar.layer.borderWidth = 2;
    _appointmentToolBar.layer.borderColor = RGBA(173, 173, 173, 1).CGColor;
    _appointmentToolBar.userInteractionEnabled = YES;
    [self.view addSubview:_appointmentToolBar];
    [_appointmentToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(0);
        make.height.equalTo(60);
    }];
    
    _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_appointmentBtn setTitle:@"预定" forState:UIControlStateNormal];
    [_appointmentBtn.titleLabel setFont:BoldSystemFont(17)];
    _appointmentBtn.layer.masksToBounds = YES;
    _appointmentBtn.layer.cornerRadius = 10;
    [_appointmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _appointmentBtn.backgroundColor = SYSTEMCOLOR;
    [_appointmentBtn addTarget:self action:@selector(appointmentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_appointmentToolBar addSubview:_appointmentBtn];
    [_appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.height.equalTo(40);
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
    }];
    
    UILabel *consumptionLabel = [[UILabel alloc] init];
    consumptionLabel.text = @"人均消费 ：";
    consumptionLabel.textColor = [UIColor darkGrayColor];
    [consumptionLabel setFont:systemFont(14)];
    [_appointmentToolBar addSubview:consumptionLabel];
    [consumptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(10);
        make.width.equalTo(75);
        make.height.equalTo(20);
    }];
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = @"联系电话 ：";
    telLabel.textColor = [UIColor darkGrayColor];
    [telLabel setFont:systemFont(14)];
    [_appointmentToolBar addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.bottom.equalTo(-10);
        make.width.equalTo(75);
        make.height.equalTo(20);
    }];
    
    _payLabel = [[UILabel alloc] init];
    _payLabel.text = @"80/人";
    _payLabel.textColor = [UIColor darkGrayColor];
    [_payLabel setFont:systemFont(14)];
    [_appointmentToolBar addSubview:_payLabel];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(consumptionLabel.mas_right);
        make.top.equalTo(consumptionLabel.mas_top);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    
    _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telBtn setTitle:@"18888888888" forState:UIControlStateNormal];
    [_telBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_telBtn.titleLabel setFont:systemFont(14)];
    _telBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_telBtn addTarget:self action:@selector(telBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_appointmentToolBar addSubview:_telBtn];
    [_telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(telLabel.mas_bottom);
        make.left.equalTo(telLabel.mas_right);
        make.width.equalTo(150);
        make.height.equalTo(20);
    }];
    
    // 注意weakSelf
    //WEAKSELF = self;
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        // 做评星后点处理
        //[weakSelf something];
    }];
    [_appointmentToolBar addSubview:self.tggStarEvaView];
    [_tggStarEvaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(telLabel.mas_bottom);
        make.right.equalTo(_appointmentBtn.mas_left).inset(5);
        make.width.equalTo(80);
        make.height.equalTo(20);
    }];
     //设置展示的星星数量
     self.tggStarEvaView.starCount = 4;
     //星星之间的间距，默认0.5
     self.tggStarEvaView.spacing = 0.1;
     //星星的点击事件使能,默认YES
     self.tggStarEvaView.tapEnabled = NO;

}

- (void)setupMapDetail {
    //初始化设置地图中心点坐标需要异步加入到主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.908862,116.397393)
                            zoomLevel:11.01 animated:NO];
    });
    //地图平移，默认YES
    _mapView.scrollEnabled = YES;
    //地图缩放，默认YES
    _mapView.zoomEnabled = YES;
    //比例尺是否显示，ƒF默认YES
    _mapView.showsScale = YES;
    
    [_mapView setShowsUserLocation:YES];
    
    //定义pointAnnotation
    QPointAnnotation *shopLocation = [[QPointAnnotation alloc] init];
    shopLocation.title = @"天安门";
    shopLocation.subtitle = @"北京市东城区东长安街";
    shopLocation.coordinate = CLLocationCoordinate2DMake(39.908862,116.397393);
    _annotations = [NSArray arrayWithObjects:shopLocation, nil];
    //向mapview添加annotation
    [_mapView addAnnotation:shopLocation];
    [_mapView viewForAnnotation:[_annotations objectAtIndex:0]].selected = YES;
}

- (void)moreFoodBtnClicked {
    
}

- (void)morePhotoBtnClicked {
    
}

- (void)telBtnClicked {
    
}

- (void)currentLocBtnClicked {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.908862,116.397393)
                            zoomLevel:11.01 animated:NO];
    });
}

- (void)onTouchBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)appointmentBtnClicked {
    SelectionVC *vc = [SelectionVC new];
    [self presentViewController:vc animated:NO completion:nil];
    //[self pushViewController:vc animated:YES];
}

#pragma mark - Delegate
- (QAnnotationView *)mapView:(QMapView *)mapView
          viewForAnnotation:(id<QAnnotation>)annotation {
    static NSString *pointReuseIndentifier = @"pointReuseIdentifier";

    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        //添加默认pinAnnotation
        if ([annotation isEqual:[_annotations objectAtIndex:0]]) {

            QPinAnnotationView *annotationView = (QPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[QPinAnnotationView alloc]
                                  initWithAnnotation:annotation
                                  reuseIdentifier:pointReuseIndentifier];
            }
            //显示气泡，默认NO
            annotationView.canShowCallout = YES;
            //设置大头针颜色
            annotationView.pinColor = QPinAnnotationColorRed;
            //添加左侧信息窗附件
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.leftCalloutAccessoryView = btn;
            //可以拖动
            annotationView.draggable = NO;
            //自定义annotation图标
            //UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
            return annotationView;
        }
    }
    return nil;
}


@end
