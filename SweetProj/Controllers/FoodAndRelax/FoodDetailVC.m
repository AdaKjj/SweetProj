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
#import "ShopDetailManager.h"
#import "UIImageView+WebCache.h"

#define BIANJU  22
#define FONT_SMALL systemFont(13)
@interface FoodDetailVC ()<QMapViewDelegate>

@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) UIImageView *appointmentToolBar;
@property (nonatomic) UIButton *appointmentBtn;
@property (nonatomic) UILabel *payLabel;
@property (nonatomic) UIButton *telBtn;
@property (nonatomic) TggStarEvaluationView *tggStarEvaView;

// 地图
@property (nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) NSArray *annotations;

// detail
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *classify;
@property (nonatomic) NSString *introduce;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *business_hours;
@property (nonatomic) NSString *avecon;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *grade;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *latitude;
@property (nonatomic) BOOL status;
@property (nonatomic) BOOL reserve;
// info
@property (nonatomic) NSString *surface;
@property (nonatomic) NSArray *recommend;
@property (nonatomic) NSArray *environment;
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
    
    // 从服务器得到详细信息
    ShopDetailManager *mana = [[ShopDetailManager alloc] init];
    mana.foodDetailVC = self;
    [mana sendRequestWithMerID:[NSString stringWithFormat:@"%d",_mer_id]];
    
    
    
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
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    topImageView.backgroundColor = COLOR_LIGHTXX_GRAY;
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.layer.masksToBounds = YES;
    [topImageView sd_setImageWithURL:[NSURL URLWithString:_surface]];;
    [_scrollView addSubview:topImageView];
    topImageView.userInteractionEnabled = YES;
    
    UIImage *round = [UIImage ellipseImageOfSize:CGSizeMake(40, 40) color:RGBA(50, 50, 50, 0.5)];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:round forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onTouchBack) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(15);
        make.width.and.height.equalTo(40);
    }];
    
    UILabel *storeLabel = [[UILabel alloc] init];
    [storeLabel setFont:BoldSystemFont(25)];
    storeLabel.text = _name;
    storeLabel.textAlignment = NSTextAlignmentCenter;
    [storeLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:storeLabel];
    [storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(topImageView.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(28);
    }];
    
    UILabel *introLabel = [[UILabel alloc] init];
    [introLabel setFont:FONT_SMALL];
    introLabel.text = _classify;
    introLabel.textAlignment = NSTextAlignmentCenter;
    [introLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:introLabel];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(storeLabel.mas_bottom).inset(10);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    UILabel *bussinessHourLabel = [[UILabel alloc] init];
    [bussinessHourLabel setFont:FONT_SMALL];
    bussinessHourLabel.text = [NSString stringWithFormat:@"营业时间： %@",_business_hours];
    bussinessHourLabel.textAlignment = NSTextAlignmentCenter;
    [bussinessHourLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:bussinessHourLabel];
    [bussinessHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(introLabel.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    UILabel *consumptionLabel = [[UILabel alloc] init];
    [consumptionLabel setFont:FONT_SMALL];
    consumptionLabel.text = [NSString stringWithFormat:@"人均消费： %@ 元",_avecon];
    consumptionLabel.textAlignment = NSTextAlignmentCenter;
    [consumptionLabel setTextColor:[UIColor blackColor]];
    [self.scrollView addSubview:consumptionLabel];
    [consumptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(bussinessHourLabel.mas_bottom).inset(15);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(18);
    }];
    
    NSAttributedString *attStr = [self getAttributedStringWithString:_introduce lineSpace:5];
    UILabel *detailLabel = [[UILabel alloc] init];
    [detailLabel setFont:FONT_SMALL];
    detailLabel.numberOfLines = 0;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.attributedText = attStr;
    CGSize textSize = [detailLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - BIANJU*2, CGFLOAT_MAX)];
    [self.scrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(consumptionLabel.mas_bottom).inset(20);
        make.width.equalTo(SCREEN_WIDTH - BIANJU*2);
        make.height.equalTo(textSize.height);
    }];
    
    //————————————————————————————————————推荐美食
    UIImage *whiteImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 22)];
    UIImageView *recommendedFoodToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    recommendedFoodToolBar.userInteractionEnabled = YES;
    [self.scrollView addSubview:recommendedFoodToolBar];
    [recommendedFoodToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLabel.mas_bottom).inset(20);
        make.left.equalTo(0);
        make.height.equalTo(18);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *recommendedFood = [[UILabel alloc]init];
    recommendedFood.text = @"推荐美食";
    recommendedFood.textColor = [UIColor blackColor];
    [recommendedFood setFont:systemFont(15)];
    [recommendedFoodToolBar addSubview:recommendedFood];
    [recommendedFood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(BIANJU);
        make.width.equalTo(100);
        make.height.equalTo(18);
    }];
    
    UIButton *moreFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreFoodBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreFoodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreFoodBtn.titleLabel setFont:FONT_SMALL];
    moreFoodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight & UIControlContentVerticalAlignmentBottom;
    [moreFoodBtn addTarget:self action:@selector(moreFoodBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [recommendedFoodToolBar addSubview:moreFoodBtn];
    [moreFoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(-BIANJU);
        make.width.equalTo(150);
        make.height.equalTo(18);
    }];
    
    UIImageView *moreFoodImageView2 = [[UIImageView alloc] init];
    moreFoodImageView2.contentMode = UIViewContentModeScaleAspectFill;
    moreFoodImageView2.layer.masksToBounds = YES;
    moreFoodImageView2.userInteractionEnabled = YES;
    [moreFoodImageView2 sd_setImageWithURL:[NSURL URLWithString:[_recommend objectAtIndex:1]]];
    [self.scrollView addSubview:moreFoodImageView2];
    [moreFoodImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    
    UIImageView *moreFoodImageView1 = [[UIImageView alloc] init];
    moreFoodImageView1.contentMode = UIViewContentModeScaleAspectFill;
    moreFoodImageView1.layer.masksToBounds = YES;
    moreFoodImageView1.userInteractionEnabled = YES;
    [moreFoodImageView1 sd_setImageWithURL:[NSURL URLWithString:[_recommend objectAtIndex:0]]];
    [self.scrollView addSubview:moreFoodImageView1];
    [moreFoodImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BIANJU);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    UIImageView *moreFoodImageView3 = [[UIImageView alloc] init];
    moreFoodImageView3.contentMode = UIViewContentModeScaleAspectFill;
    moreFoodImageView3.layer.masksToBounds = YES;
    moreFoodImageView3.userInteractionEnabled = YES;
    [moreFoodImageView3 sd_setImageWithURL:[NSURL URLWithString:[_recommend objectAtIndex:2]]];
    [self.scrollView addSubview:moreFoodImageView3];
    [moreFoodImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moreFoodImageView2.mas_right).inset(15);
        make.top.equalTo(recommendedFoodToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    //————————————————————————————————————更多照片导航栏
    UIImageView *morePhotoToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    morePhotoToolBar.userInteractionEnabled = YES;
    [self.scrollView addSubview:morePhotoToolBar];
    [morePhotoToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreFoodImageView2.mas_bottom).inset(15);
        make.left.equalTo(0);
        make.height.equalTo(22);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *morePhotoLabel = [[UILabel alloc]init];
    morePhotoLabel.text = @"店内环境";
    morePhotoLabel.textColor = [UIColor blackColor];
    [morePhotoLabel setFont:systemFont(15)];
    [morePhotoToolBar addSubview:morePhotoLabel];
    [morePhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(BIANJU);
        make.width.equalTo(100);
        make.height.equalTo(18);
    }];
    
    UIButton *morePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [morePhotoBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [morePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [morePhotoBtn.titleLabel setFont:FONT_SMALL];
    morePhotoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight & UIControlContentVerticalAlignmentBottom;
    [morePhotoBtn addTarget:self action:@selector(morePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [morePhotoToolBar addSubview:morePhotoBtn];
    [morePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(-BIANJU);
        make.width.equalTo(150);
        make.height.equalTo(18);
    }];
    
    UIImageView *morePhotoImageView2 = [[UIImageView alloc] init];
    morePhotoImageView2.contentMode = UIViewContentModeScaleAspectFill;
    morePhotoImageView2.layer.masksToBounds = YES;
    morePhotoImageView2.userInteractionEnabled = YES;
    [morePhotoImageView2 sd_setImageWithURL:[NSURL URLWithString:[_environment objectAtIndex:1]]];
    [self.scrollView addSubview:morePhotoImageView2];
    [morePhotoImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    UIImageView *morePhotoImageView1 = [[UIImageView alloc] init];
    morePhotoImageView1.contentMode = UIViewContentModeScaleAspectFill;
    morePhotoImageView1.layer.masksToBounds = YES;
    morePhotoImageView1.userInteractionEnabled = YES;
    [morePhotoImageView1 sd_setImageWithURL:[NSURL URLWithString:[_environment objectAtIndex:0]]];
    [self.scrollView addSubview:morePhotoImageView1];
    [morePhotoImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BIANJU);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    UIImageView *morePhotoImageView3 = [[UIImageView alloc] init];
    morePhotoImageView3.contentMode = UIViewContentModeScaleAspectFill;
    morePhotoImageView3.layer.masksToBounds = YES;
    morePhotoImageView3.userInteractionEnabled = YES;
    [self.scrollView addSubview:morePhotoImageView3];
    [morePhotoImageView3 sd_setImageWithURL:[NSURL URLWithString:[_environment objectAtIndex:2]]];
    [morePhotoImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(morePhotoImageView2.mas_right).inset(15);
        make.top.equalTo(morePhotoToolBar.mas_bottom).inset(5);
        make.height.width.equalTo((SCREEN_WIDTH - 30 - BIANJU*2)/3);
    }];
    
    UIImage *lineImage = [UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(SCREEN_WIDTH - BIANJU*2, 2.5)];
    UIImageView *lineImageView = [[UIImageView alloc]initWithImage:lineImage];
    [self.scrollView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(morePhotoImageView1.bottom).inset(35);
        make.left.equalTo(BIANJU);
        make.height.equalTo(3);
        make.width.equalTo(SCREEN_WIDTH - BIANJU*2);
    }];
    
    UILabel *mapLabel = [[UILabel alloc] init];
    mapLabel.text = @"地图";
    mapLabel.textColor = [UIColor blackColor];
    mapLabel.textAlignment = NSTextAlignmentCenter;
    mapLabel.backgroundColor = [UIColor whiteColor];
    [mapLabel setFont:systemFont(16)];
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
    
    UIButton *currentLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    currentLocBtn.userInteractionEnabled = YES;
    [currentLocBtn setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [currentLocBtn setImage:[UIImage imageNamed:@"map_select"] forState:UIControlStateHighlighted];
    [currentLocBtn addTarget:self action:@selector(currentLocBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:currentLocBtn];
    [currentLocBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [circleLabel setFont:systemFont(16)];
    [self.scrollView addSubview:circleLabel];
    [circleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lineImageView2.mas_centerX);
        make.centerY.equalTo(lineImageView2.mas_centerY);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1300);
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [morePhotoImageView1 addGestureRecognizer:tapGestureRecognizer1];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [morePhotoImageView2 addGestureRecognizer:tapGestureRecognizer2];
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [morePhotoImageView3 addGestureRecognizer:tapGestureRecognizer3];
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [moreFoodImageView1 addGestureRecognizer:tapGestureRecognizer4];
    UITapGestureRecognizer *tapGestureRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [moreFoodImageView2 addGestureRecognizer:tapGestureRecognizer5];
    UITapGestureRecognizer *tapGestureRecognizer6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [moreFoodImageView3 addGestureRecognizer:tapGestureRecognizer6];
}

- (void)getShopDetail:(NSDictionary *)valueDic {
    self.shopDetailModel = [[ShopDetailModel alloc] initWithDictionary:valueDic error:nil];
    self.business_hours = self.shopDetailModel.shopdes.business_hours;
    self.name        = self.shopDetailModel.shopdes.name;
    self.classify    = self.shopDetailModel.shopdes.classify;
    self.avecon      = self.shopDetailModel.shopdes.avecon;
    self.introduce   = self.shopDetailModel.shopdes.introduce;
    self.longitude   = self.shopDetailModel.shopdes.longitude;
    self.latitude    = self.shopDetailModel.shopdes.latitude;
    self.phone       = self.shopDetailModel.shopdes.phone;
    self.grade       = self.shopDetailModel.shopdes.grade;
    self.address     = self.shopDetailModel.shopdes.address;
    self.status      = self.shopDetailModel.shopdes.status;
    self.reserve     = self.shopDetailModel.shopdes.reserve;
    self.time        = self.shopDetailModel.shopdes.time;
    self.surface     = self.shopDetailModel.surface;
    self.recommend   = self.shopDetailModel.recommend;
    self.environment = self.shopDetailModel.environment;
    if (self.name) {
    [self setupScrollView];
    [self setupMapDetail];
    [self configAppointmentToolBar];
    }
}

//TODO：圈子
- (void)getCircleArr:(NSDictionary *)valueDic {
    
}

-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
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
    [consumptionLabel setFont:FONT_SMALL];
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
    _payLabel.text = [NSString stringWithFormat:@"%@/人",_avecon];
    _payLabel.textColor = [UIColor darkGrayColor];
    [_payLabel setFont:FONT_SMALL];
    [_appointmentToolBar addSubview:_payLabel];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(consumptionLabel.mas_right);
        make.top.equalTo(consumptionLabel.mas_top);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    
    _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telBtn setTitle:_phone forState:UIControlStateNormal];
    [_telBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_telBtn.titleLabel setFont:FONT_SMALL];
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
     self.tggStarEvaView.starCount = [_grade intValue];
     //星星之间的间距，默认0.5
     self.tggStarEvaView.spacing = 0.1;
     //星星的点击事件使能,默认YES
     self.tggStarEvaView.tapEnabled = NO;

}

- (void)setupMapDetail {
    //初始化设置地图中心点坐标需要异步加入到主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([_latitude floatValue],[_longitude floatValue])
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
    shopLocation.title = _name;
    shopLocation.subtitle = _address;
    shopLocation.coordinate = CLLocationCoordinate2DMake([_latitude floatValue],[_longitude floatValue]);
    _annotations = [NSArray arrayWithObjects:shopLocation, nil];
    //向mapview添加annotation
    [_mapView addAnnotation:shopLocation];
    [_mapView viewForAnnotation:[_annotations objectAtIndex:0]].selected = YES;
}


/**
 label添加字符串

 @param string label.text
 @param lineSpace 行间距
 @return 返回添加行间距后的字
 */
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSFontAttributeName value:FONT_SMALL range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}


- (void)moreFoodBtnClicked {
    
}

- (void)morePhotoBtnClicked {
    
}

- (void)telBtnClicked {
    
}

- (void)currentLocBtnClicked {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([_latitude floatValue],[_longitude floatValue])
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
