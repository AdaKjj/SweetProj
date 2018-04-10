//
//  ReservationInfoVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/4.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ReservationInfoVC.h"
#import "UIImage+Addition.h"
#import "UITextFieldEx.h"
#import "ConfirmReservationVC.h"

@interface ReservationInfoVC ()<UITextFieldDelegate>

@property (nonatomic) UIButton *orderBtn;

@property (nonatomic) UITextField *timeTF;
@property (nonatomic) UITextField *countTF;
@property (nonatomic) UITextField *nameTF;
@property (nonatomic) UITextFieldPhone *telTF;
@property (nonatomic) UITextField *infoTF;
@property (nonatomic, strong) UIDatePicker *timePicker;

@property (nonatomic) UIControl *baseControl;

@end

@implementation ReservationInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.title = @"预定信息";
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reservationBg"]];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.height.equalTo(self.view.height);
        make.width.equalTo(self.view.width);
    }];
    
    _baseControl = [[UIControl alloc] initWithFrame:self.view.bounds];
    _baseControl.backgroundColor = [UIColor clearColor];
    [_baseControl addTarget:self action:@selector(onTouchDismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupOrderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    //导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
}

- (void)setupOrderView {
    UIImageView *orderBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orderBg"]];
    orderBg.userInteractionEnabled = YES;
    [self.view addSubview:orderBg];
    [orderBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(0);
        make.height.equalTo(500);
        make.width.equalTo (SCREEN_WIDTH - 60);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"填写座位信息";
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setFont:systemFont(18)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(35);
        make.centerX.equalTo(0);
        make.width.equalTo(150);
        make.height.equalTo(22);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"时间 ：";
    [timeLabel setFont:systemFont(15)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(100);
        make.left.equalTo(45);
        make.width.equalTo(60);
        make.height.equalTo(17);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;

    _timeTF = [[UITextField alloc] init];
    _timeTF.borderStyle = UITextBorderStyleNone;
    self.timeTF.attributedPlaceholder = [NSAttributedString.alloc initWithString:@"请选择"
                                                                      attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    _timeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _timeTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _timeTF.textAlignment = NSTextAlignmentCenter;
    _timeTF.layer.borderWidth = 1.0f;
    _timeTF.layer.cornerRadius = 5;
    _timeTF.font = systemFont(15);
    [orderBg addSubview:_timeTF];
    [_timeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLabel.centerY);
        make.left.equalTo(timeLabel.mas_right).inset(25);
        make.right.equalTo(-45);
        make.height.equalTo(26);
    }];
    _timeTF.delegate = self;

    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.text = @"人数 ：";
    [countLabel setFont:systemFont(15)];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).inset(25);
        make.left.equalTo(45);
        make.width.equalTo(60);
        make.height.equalTo(17);
    }];
    
    _countTF = [[UITextField alloc] init];
    _countTF.placeholder = @"请填写";
    self.countTF.attributedPlaceholder = [NSAttributedString.alloc initWithString:@"请填写"
                                                                      attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    self.countTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.countTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _countTF.keyboardType = UIKeyboardTypeNumberPad;
    _countTF.borderStyle = UITextBorderStyleNone;
    _countTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _countTF.textAlignment = NSTextAlignmentCenter;
    _countTF.layer.borderWidth = 1.0f;
    _countTF.layer.cornerRadius = 5;
    _countTF.font = systemFont(15);
    [orderBg addSubview:_countTF];
    [_countTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countLabel.centerY);
        make.left.equalTo(countLabel.mas_right).inset(25);
        make.right.equalTo(-45);
        make.height.equalTo(26);
    }];
    _countTF.delegate = self;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"姓名 ：";
    [nameLabel setFont:systemFont(15)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countLabel.mas_bottom).equalTo(25);
        make.left.equalTo(45);
        make.width.equalTo(60);
        make.height.equalTo(17);
    }];
    
    _nameTF = [[UITextField alloc] init];
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.keyboardType = UIKeyboardTypeDefault;
    _nameTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _nameTF.layer.borderWidth = 1.0f;
    _nameTF.layer.cornerRadius = 5;
    _nameTF.textAlignment = NSTextAlignmentCenter;
    _nameTF.font = systemFont(15);
    [orderBg addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel.centerY);
        make.left.equalTo(nameLabel.mas_right).inset(25);
        make.right.equalTo(-45);
        make.height.equalTo(26);
    }];
    _nameTF.delegate = self;
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = @"电话 ：";
    [telLabel setFont:systemFont(15)];
    telLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).equalTo(25);
        make.left.equalTo(45);
        make.width.equalTo(60);
        make.height.equalTo(17);
    }];
    
    _telTF = [[UITextFieldPhone alloc] init];
    _telTF.borderStyle = UITextBorderStyleNone;
    _telTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _telTF.layer.borderWidth = 1.0f;
    _telTF.layer.cornerRadius = 5;
    _telTF.textAlignment = NSTextAlignmentCenter;
    _telTF.font = systemFont(15);
    [orderBg addSubview:_telTF];
    [_telTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telLabel.centerY);
        make.left.equalTo(telLabel.mas_right).inset(25);
        make.right.equalTo(-45);
        make.height.equalTo(26);
    }];
    _telTF.delegate = self;
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"备注 ：";
    [infoLabel setFont:systemFont(15)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [orderBg addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telLabel.mas_bottom).equalTo(25);
        make.left.equalTo(45);
        make.width.equalTo(60);
        make.height.equalTo(17);
    }];
    
    _infoTF = [[UITextField alloc] init];
    _infoTF.borderStyle = UITextBorderStyleNone;
    _infoTF.layer.borderWidth = 1.0f;
    _infoTF.layer.cornerRadius = 5;
    _infoTF.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _infoTF.font = systemFont(15);
    [orderBg addSubview:_infoTF];
    [_infoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoLabel.mas_left);
        make.top.equalTo(infoLabel.mas_bottom).inset(10);
        make.height.equalTo(90);
        make.right.equalTo(-45);
    }];
    _infoTF.delegate = self;
    
    _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_orderBtn setTitle:@"预定" forState:UIControlStateNormal];
    [_orderBtn.titleLabel setFont:BoldSystemFont(17)];
    _orderBtn.layer.masksToBounds = YES;
    _orderBtn.layer.cornerRadius = 19;
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderBtn.backgroundColor = SYSTEMCOLOR;
    [_orderBtn addTarget:self action:@selector(orderBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [orderBg addSubview:_orderBtn];
    [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoLabel.mas_left);
        make.height.equalTo(38);
        make.right.equalTo(-45);
        make.bottom.equalTo(-40);
    }];
}


- (void)orderBtnClicked {
    ConfirmReservationVC *vc = [[ConfirmReservationVC alloc] init];
    vc.shopCarArr = _shopCarArr;
    vc.totalPrice = self.totalPrice;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textFieldDelegate
- (void)onTouchDismiss:(id)sender
{
    [self.view endEditing:YES];
    [_baseControl removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addSubview:_baseControl];
}

//完成
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    NSString *str = textField.text;
//    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    if (!str){
//        //有
//        return YES;
//    }
//    else{
//        [textField resignFirstResponder];
//        return YES;
//    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 不能加空格
    if (textField != _infoTF) {
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
        if (![string isEqualToString:tem]) {
            return  NO;
        }
    }
    return YES;
}

@end
