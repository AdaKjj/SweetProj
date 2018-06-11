//
//  MainVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "MainVC.h"
#import "Masonry.h"
#import "LoginVC.h"
#import "AdCell.h"
#import "AdCellLayout.h"
#import "MainItemCell.h"
#import "UIImage+Addition.h"
#import "FoodPreviewVC.h"
#import "FoodDetailVC.h"

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "MainManager.h"
#import "WeatherManager.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"
#import "UIButton+EdgeInsets.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
#define IS_IOS_VERSION_11 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)? (YES):(NO))

#define FONT_TOPIC systemFont(17)
#define FONT_OTHER systemFont(13)

#define TOOLBARHEIGHT 55

@interface MainVC ()<UISearchBarDelegate, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, JFCityViewControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic) UIButton *loginBtn;
/** 导航栏*/
@property (nonatomic) UIButton *leftButton;
@property (nonatomic) UITextField *searchTF;
@property (nonatomic) UIButton *weatherBtn;

@property (nonatomic) UIScrollView *scrollView;

/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic) UICollectionView *topicCollectionView;

@property (nonatomic) UICollectionView *foodCollectionView;
@property (nonatomic) UIButton *moreFoodBtn;
@property (nonatomic) UICollectionView *relaxCollectionView;
@property (nonatomic) UIButton *moreRelaxBtn;
@property (assign,  nonatomic) bool isPop;

@property (nonatomic) CLLocationManager *clLocationManager;

@property (nonatomic) UIControl *baseControl;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(243, 243, 243);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _baseControl = [[UIControl alloc] initWithFrame:self.view.bounds];
    _baseControl.backgroundColor = [UIColor clearColor];
    [_baseControl addTarget:self action:@selector(onTouchDismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(logoutNoti)
               name:@"logout"
             object:nil];
    
    [self startLocation];
    
    [self configCollectionView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setupLoginBtn];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController setHidesBottomBarWhenPushed:NO];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:
    [UIImage imageNamed:@"navBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self setupSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutNoti {
    [self loginBtnClick];
}

- (void)setupLoginBtn {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //BOOL isLogin = [userDefaults objectForKey:@"username"];
    if (![userDefaults objectForKey:@"Session"]) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(20);
            make.height.width.equalTo(50);
        }];
    }
    else {
        _loginBtn.hidden = YES;
    }
}

- (void)configCollectionView
{
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = RGB(243, 243, 243);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
    
    UIImageView *toolbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    toolbar.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:toolbar];
    toolbar.userInteractionEnabled = YES;

    //左侧城市
    UIImage *leftImage = [UIImage imageNamed:@"定位"];
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setImage:leftImage forState:UIControlStateNormal];
    [_leftButton setTitle:@"定位中" forState:UIControlStateNormal];
    [_leftButton setTitleColor:CELL_TEXT_COLOR forState:UIControlStateNormal];
    [_leftButton.titleLabel setFont:BoldSystemFont(18)];
    _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_leftButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:3];
    [_leftButton addTarget:self action:@selector(locBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(16);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    UIButton *qrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qrBtn addTarget:self action:@selector(qrBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image2 = [[UIImage imageNamed:@"qrcodescan"] resizedImage:CGSizeMake(30, 30) interpolationQuality:kCGInterpolationHigh];
    [qrBtn setImage:image2 forState:UIControlStateNormal];
    [qrBtn setTitle:@"扫一扫点餐" forState:UIControlStateNormal];
    [qrBtn setTitleColor:CELL_TEXT_COLOR forState:UIControlStateNormal];
    [qrBtn.titleLabel setFont:systemFont(11)];
    qrBtn.frame = CGRectMake(SCREEN_WIDTH - 80, -3, 90, 60);
    CGSize size2 = [qrBtn.titleLabel.text sizeWithFont:systemFont(11) constrainedToSize:CGSizeMake(MAXFLOAT, qrBtn.titleLabel.frame.size.height)];
    qrBtn.titleEdgeInsets =UIEdgeInsetsMake(0.5*image2.size.height, -0.5*image2.size.width, -0.5*image2.size.height, 0.5*image2.size.width);
    qrBtn.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size2.height, 0.5*size2.width, 0.5*size2.height, -0.5*size2.width);
    [toolbar addSubview:qrBtn];
    
    _weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"w101"] resizedImage:CGSizeMake(30, 30) interpolationQuality:kCGInterpolationHigh];
    //UIImage *image = [UIImage imageNamed:@"w101"];
    [_weatherBtn setImage:[UIImage imageNamed:@"w101"] forState:UIControlStateNormal];
    [_weatherBtn setTitle:@"等待定位" forState:UIControlStateNormal];
    [_weatherBtn.titleLabel setFont:systemFont(11)];
    [_weatherBtn setTitleColor:CELL_TEXT_COLOR forState:UIControlStateNormal];
    _weatherBtn.frame = CGRectMake(SCREEN_WIDTH - 140, -5, 90, 60);
    CGSize size1 = [_weatherBtn.titleLabel.text sizeWithFont:systemFont(11) constrainedToSize:CGSizeMake(MAXFLOAT, _weatherBtn.titleLabel.frame.size.height)];
    self.weatherBtn.titleEdgeInsets =UIEdgeInsetsMake(0.5*image.size.height, -0.5*image.size.width, -0.5*image.size.height, 0.5*image.size.width);
    self.weatherBtn.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
    [toolbar addSubview:_weatherBtn];
    
    //————————————————————————————专题
    //1.初始化ToopicAdlayout
    AdCellLayout *layout = [[AdCellLayout alloc] init];
    //2.初始化collectionView
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _topicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOOLBARHEIGHT, SCREEN_WIDTH, 200) collectionViewLayout:layout];
    _topicCollectionView.tag = 0;
    [_scrollView addSubview:_topicCollectionView];
    
    //隐藏水平滚动条
    _topicCollectionView.showsHorizontalScrollIndicator = NO;
    _topicCollectionView.backgroundColor = [UIColor whiteColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_topicCollectionView registerClass:[AdCell class] forCellWithReuseIdentifier:@"topicCell"];
    //4.设置代理
    _topicCollectionView.delegate = self;
    _topicCollectionView.dataSource = self;
    
    //————————————————————————————————————美食导航栏
    UIImage *whiteImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 30)];
    UIImageView *foodToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    foodToolBar.userInteractionEnabled = YES;
    [_scrollView addSubview:foodToolBar];
    [foodToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(215+TOOLBARHEIGHT);
        make.left.equalTo(0);
        make.height.equalTo(25);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *foodLabel = [[UILabel alloc]init];
    foodLabel.text = @"美食";
    foodLabel.textColor = RGB(75, 173, 96);
    [foodLabel setFont:FONT_TOPIC];
    [foodToolBar addSubview:foodLabel];
    [foodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(15);
        make.width.equalTo(70);
        make.height.equalTo(19);
    }];
    
    _moreFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreFoodBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [_moreFoodBtn setTitleColor:RGB(75, 173, 96) forState:UIControlStateNormal];
    [_moreFoodBtn.titleLabel setFont:FONT_OTHER];
    _moreFoodBtn.contentHorizontalAlignment =  UIControlContentVerticalAlignmentBottom;
    [_moreFoodBtn addTarget:self action:@selector(moreFoodBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [foodToolBar addSubview:_moreFoodBtn];
    [_moreFoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-12);
        make.width.equalTo(80);
        make.height.equalTo(14);
    }];
    
    //————————————————————————————美食
    UICollectionViewFlowLayout *foodLayout = [[UICollectionViewFlowLayout alloc] init];
    foodLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _foodCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 240+TOOLBARHEIGHT, SCREEN_WIDTH, 160) collectionViewLayout:foodLayout];
    _foodCollectionView.tag = 2;
    [_scrollView addSubview:_foodCollectionView];
    
    _foodCollectionView.showsVerticalScrollIndicator = NO;
    _foodCollectionView.backgroundColor = [UIColor whiteColor];
    [_foodCollectionView registerClass:[MainItemCell class] forCellWithReuseIdentifier:@"mainCell"];
    _foodCollectionView.delegate = self;
    _foodCollectionView.dataSource = self;
    
    //————————————————————————————————————休闲娱乐导航栏
    UIImageView *relaxToolBar = [[UIImageView alloc]initWithImage:whiteImage];
    relaxToolBar.userInteractionEnabled = YES;
    [_scrollView addSubview:relaxToolBar];
    [relaxToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(415+TOOLBARHEIGHT);
        make.left.equalTo(0);
        make.height.equalTo(25);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *relaxLabel = [[UILabel alloc]init];
    relaxLabel.text = @"休闲娱乐";
    relaxLabel.textColor = RGB(84, 123, 199);
    [relaxLabel setFont:FONT_TOPIC];
    [relaxToolBar addSubview:relaxLabel];
    [relaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(15);
        make.width.equalTo(100);
        make.height.equalTo(25);
    }];
    
    _moreRelaxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreRelaxBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [_moreRelaxBtn setTitleColor:RGB(84, 123, 199) forState:UIControlStateNormal];
    [_moreRelaxBtn.titleLabel setFont:FONT_OTHER];
    _moreRelaxBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentBottom;
    [_moreRelaxBtn addTarget:self action:@selector(moreRelaxBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [relaxToolBar addSubview:_moreRelaxBtn];
    [_moreRelaxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-12);
        make.width.equalTo(80);
        make.height.equalTo(30);
    }];
    //————————————————————————————休闲娱乐
    UICollectionViewFlowLayout *relaxLayout = [[UICollectionViewFlowLayout alloc] init];
    relaxLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _relaxCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 440+TOOLBARHEIGHT, SCREEN_WIDTH, 160) collectionViewLayout:relaxLayout];
    _relaxCollectionView.tag = 3;
    [_scrollView addSubview:_relaxCollectionView];
    
    _relaxCollectionView.showsVerticalScrollIndicator = NO;
    _relaxCollectionView.backgroundColor = [UIColor whiteColor];
    [_relaxCollectionView registerClass:[MainItemCell class] forCellWithReuseIdentifier:@"relaxCell"];
    _relaxCollectionView.delegate = self;
    _relaxCollectionView.dataSource = self;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _relaxCollectionView.frame.origin.y + _relaxCollectionView.frame.size.height);
}

- (void)getAdArr:(NSDictionary *)jsonDic {    
    self.recreationModel = [[RecreationModel alloc] initWithDictionary:jsonDic error:nil];
    self.foodModel = [[FoodCollectionModel alloc] initWithDictionary:jsonDic error:nil];
    self.advertisingModel = [[AdvertisingModel alloc] initWithDictionary:jsonDic error:nil];
    [_foodCollectionView reloadData];
    [_relaxCollectionView reloadData];
    [_topicCollectionView reloadData];
}

- (void)getWeathertmp:(NSString *)tmp condTxt:(NSString *)condTxt condCode:(NSString *)condCode lat:(NSString *)lat lon:(NSString *)lon city:(NSString *)city {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"w%@",condCode]];
    [ _weatherBtn setImage:image forState:UIControlStateNormal];
    [_weatherBtn setTitle:[NSString stringWithFormat:@"%@ %@",condTxt,tmp] forState:UIControlStateNormal];
    
    CGSize size1 = [_weatherBtn.titleLabel.text sizeWithFont:systemFont(11) constrainedToSize:CGSizeMake(MAXFLOAT, _weatherBtn.titleLabel.frame.size.height)];
    self.weatherBtn.titleEdgeInsets = UIEdgeInsetsMake(0.5*image.size.height, -0.5*image.size.width, -0.5*image.size.height, 0.5*image.size.width);
    self.weatherBtn.imageEdgeInsets = UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
    
    if (![_leftButton.titleLabel.text isEqualToString:city] && ![_leftButton.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%@市",city]]) {
        [self sendRequestWithLon:lon andLat:lat];
    }
}

- (void)loginBtnClick
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)setupSearchBar {
    //搜索框
    UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 20, 20)];
    searchImageView.image = [UIImage imageNamed:@"SearchIcon"];
    searchImageView.contentMode = UIViewContentModeCenter;
    [leftView addSubview:searchImageView];
    
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 88,35)];
    _searchTF.borderStyle = UITextBorderStyleNone;
    _searchTF.textColor = [UIColor blackColor];
    _searchTF.backgroundColor = [UIColor whiteColor];
    _searchTF.font = systemFont(14);
    _searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"在Sweet上搜索"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _searchTF.layer.cornerRadius = 20;
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.clearButtonMode = UITextFieldViewModeAlways;
    _searchTF.leftView = leftView;
    _searchTF.clearsOnBeginEditing = YES;
    _searchTF.tag = 1;
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = _searchTF;
    _searchTF.delegate = self;
}

- (void)qrBtnClicked {
    
}

- (void)moreFoodBtnClicked {
    FoodPreviewVC *vc = [[FoodPreviewVC alloc]init];
    vc.topicString = @"美食";
    vc.cityString = _leftButton.titleLabel.text;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)moreRelaxBtnClicked {
    FoodPreviewVC *vc = [[FoodPreviewVC alloc]init];
    vc.topicString = @"休闲娱乐";
    vc.cityString = _leftButton.titleLabel.text;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)locBtnClicked {
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.delegate = self;
    cityViewController.title = @"城市";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)startLocation{
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        self.clLocationManager = [[CLLocationManager alloc] init];
        self.clLocationManager.delegate = self;//遵循代理
        self.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.clLocationManager.distanceFilter = 10.0f;
        [self.clLocationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        [self.clLocationManager startUpdatingLocation];//开始定位
    }
    else {
        // TODO:定位不成功时返回
        //不能定位用户的位置的情况再次进行判断，并给与用户提示
        //1.提醒用户检查当前的网络状况
        //2.提醒用户打开定位开关
        
    }
}

- (void)sendRequestWithLon:(NSString *)lon andLat:(NSString *)lat {
    MainManager *mana = [[MainManager alloc] init];
    mana.mainVC = self;
    [mana sendRequestWithLong:lon lat:lat];
}

- (void)sendRequestWithCity:(NSString *)city {
    WeatherManager *mana = [[WeatherManager alloc] init];
    mana.mainVC = self;
    [mana sendRequestWithCity:city];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *address = [placemark addressDictionary];
            //  Country(国家)  State(省)  City（市）
            
            [_leftButton setTitle:[address objectForKey:@"City"] forState:UIControlStateNormal];
            [_leftButton setTitle:[address objectForKey:@"City"] forState:UIControlStateSelected];
            
            NSString *lat = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
            NSString *lon =[NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];

            [self sendRequestWithLon:lon andLat:lat];
            [self sendRequestWithCity:[address objectForKey:@"City"]];
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}


#pragma mark - JFCityViewControllerDelegate

- (void)cityName:(NSString *)name {
    [_leftButton setTitle:name forState:UIControlStateNormal];
    [_leftButton setTitle:name forState:UIControlStateSelected];
}

#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    DLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_leftButton.titleLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_leftButton setTitle:city forState:UIControlStateNormal];
            [_leftButton setTitle:city forState:UIControlStateSelected];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    DLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    DLog(@"%@",message);
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 0) {
        return [self.advertisingModel.advertising count];
    }
    else if (collectionView.tag == 2) {
        return self.foodModel.food.count;
    }
    return [self.recreationModel.recreation count] ;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView .tag == 0) {
        return CGSizeMake(196, 140);
    }
    else {
        return CGSizeMake(186, 160);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        self.adUrlModel = self.advertisingModel.advertising[indexPath.row];
        NSURL *imageUrl = _adUrlModel.url;
        AdCell *cell = (AdCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"topicCell" forIndexPath:indexPath];
        [cell.adImageView sd_setImageWithURL:imageUrl];
        return cell;
    }
    else if (collectionView.tag == 2) {
        self.oneRecreationModel = self.foodModel.food[indexPath.row];
        
        MainItemCell *cell = (MainItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
        cell.mer_id = self.oneRecreationModel.mer_id;
        [cell.storeImageView sd_setImageWithURL:self.oneRecreationModel.pho_url];
        cell.storNameLabel.text = self.oneRecreationModel.name;
        cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f公里",self.oneRecreationModel.distance];
        cell.numOfCommentLabel.text = [NSString stringWithFormat:@"%d条评论",self.oneRecreationModel.time];
        cell.typeLabel.text = self.oneRecreationModel.classify;
            cell.storNameLabel.textColor = RGB(75, 173, 96);
            cell.numOfCommentLabel.textColor = RGB(75, 173, 96);
            cell.typeLabel.textColor = RGB(75, 173, 96);

        return cell;
    }
    else {
        self.oneRecreationModel = self.recreationModel.recreation[indexPath.row];
        
        MainItemCell *cell = (MainItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"relaxCell" forIndexPath:indexPath];
        [cell.storeImageView sd_setImageWithURL:self.oneRecreationModel.pho_url];
        cell.mer_id = self.oneRecreationModel.mer_id;
        cell.storNameLabel.text = self.oneRecreationModel.name;
        cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f公里",self.oneRecreationModel.distance];
        cell.numOfCommentLabel.text = [NSString stringWithFormat:@"%d条评论",self.oneRecreationModel.time];
        cell.typeLabel.text = self.oneRecreationModel.classify;
        cell.storNameLabel.textColor = RGB(84, 123, 199);
        cell.numOfCommentLabel.textColor = RGB(84, 123, 199);
        cell.typeLabel.textColor = RGB(84, 123, 199);
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 2 || collectionView.tag == 3) {
        MainItemCell *cell = (MainItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        FoodDetailVC *detailVC = [[FoodDetailVC alloc] init];
        detailVC.mer_id = cell.mer_id;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

/**
 * Section中每个Cell的上下边距
 */
- (CGFloat)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex: (NSInteger)section{
    if (collectionView.tag == 2 || collectionView.tag == 3)
    {
        return 20.0f;
    }
    return 15.0f;
}


//Asks the delegate for the margins to apply to content in the specified section.安排初始位置
//使前后项都能居中显示
- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 0) {
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
                            0, (collectionView.bounds.size.width - lastSize.width) / 2);
    }
    else {
        return UIEdgeInsetsMake(0,10,0,10);
    }
}

#pragma mark - textFieldDelegate
- (void)onTouchDismiss:(id)sender
{
    [_searchTF endEditing:YES];
    [_baseControl removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view insertSubview:_baseControl aboveSubview:_topicCollectionView];
}

//完成
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *str = textField.text;
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (!str){
        //有
        return YES;
    }
    else{
        [textField resignFirstResponder];
        return YES;
    }
}

@end
