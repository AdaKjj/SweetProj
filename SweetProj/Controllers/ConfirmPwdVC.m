//
//  ConfirmPwdVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "ConfirmPwdVC.h"
#import "LoginRegisterManager.h"
#import "MainVC.h"
#import "GetBackPwdManager.h"
#import "UITextFieldEx.h"

@interface ConfirmPwdVC ()<UITextFieldDelegate>

@property (nonatomic) UIImageView *bgImageView;
@property (nonatomic) UIImageView *registerLogo;

@property (nonatomic) UITextFieldPwd *pwdTF;
@property (nonatomic) UITextFieldPwd *pwdSubmitTF;

@property (nonatomic) UIButton *completeRegisterBtn;

@end

@implementation ConfirmPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userBg"]];
    [self.view addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.height.equalTo(self.view.height);
        make.width.equalTo(self.view.width);
    }];
    
    //设置导航条
    self.navigationItem.title = _fromVCStr;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    
    UIImage *backBarImage = [UIImage imageNamed:@"backBarBtnClicked"];
    backBarImage = [self reSizeImage:backBarImage toSize:CGSizeMake(30, 22)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:backBarImage
                                                            style:UIBarButtonItemStylePlain
                                                           target:self action:@selector(backBtnPressed)];
    self.navigationItem.leftBarButtonItem = item;
    
    _registerLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registerLogo"]];
    [self.view addSubview:_registerLogo];
    [_registerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(70);
        make.height.equalTo(200);
        make.width.equalTo(200);
    }];
    
    
    UIImageView *emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 26)];
    emailImageView.image = [UIImage imageNamed:@"pwd"];
    emailImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pwdTF = [[UITextFieldPwd alloc] init];
    _pwdTF.borderStyle = UITextBorderStyleNone;
    _pwdTF.textColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1];
    _pwdTF.backgroundColor = [UIColor clearColor];
    _pwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1]}];
    _pwdTF.layer.borderWidth = 2.0f;
    _pwdTF.layer.cornerRadius = 20;
    _pwdTF.layer.borderColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1].CGColor;
    _pwdTF.clearButtonMode = UITextFieldViewModeAlways;
    _pwdTF.leftView = emailImageView;
    _pwdTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_pwdTF];
    [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_registerLogo.mas_bottom).inset(60);
        make.height.equalTo(40);
        make.width.equalTo(300);
    }];
    _pwdTF.delegate = self;
    
    UIImageView *VerificationCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 26)];
    VerificationCodeImageView.image = [UIImage imageNamed:@"changePwd"];
    VerificationCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pwdSubmitTF = [[UITextFieldPwd alloc] init];
    _pwdSubmitTF.borderStyle = UITextBorderStyleNone;
    _pwdSubmitTF.textColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1];
    _pwdSubmitTF.backgroundColor = [UIColor clearColor];
    _pwdSubmitTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请确认密码"
                                                                                attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1]}];
    _pwdSubmitTF.layer.borderWidth = 2.0f;
    _pwdSubmitTF.layer.cornerRadius = 20;
    _pwdSubmitTF.layer.borderColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1].CGColor;
    _pwdSubmitTF.clearButtonMode = UITextFieldViewModeAlways;
    _pwdSubmitTF.leftView = VerificationCodeImageView;
    _pwdSubmitTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_pwdSubmitTF];
    [_pwdSubmitTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_pwdTF.mas_bottom).inset(20);
        make.height.equalTo(40);
        make.width.equalTo(300);
    }];
    _pwdSubmitTF.delegate = self;
    
    _completeRegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_completeRegisterBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    [_completeRegisterBtn setTitleColor:[UIColor blackColor]
                       forState:UIControlStateNormal];
    [_completeRegisterBtn setBackgroundColor:[UIColor whiteColor]];
    _completeRegisterBtn.layer.cornerRadius = 20;
    [_completeRegisterBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_completeRegisterBtn addTarget:self action:@selector(completRegisterClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_completeRegisterBtn];
    [_completeRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_pwdSubmitTF.mas_bottom).inset(30);
        make.height.equalTo(40);
        make.width.equalTo(150);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)backBtnPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)completRegisterClicked {
    NSString *errorMessage;
    if (_pwdTF.text.length == 0 || _pwdSubmitTF.text.length == 0) {
        errorMessage = [NSString stringWithFormat:@"请输入密码以及确认密码"];
    }
    else {
        if ([_pwdTF.text isEqualToString:_pwdSubmitTF.text]) {
            if ([_pwdTF isValid:&errorMessage]) {
                if ([_fromVCStr isEqualToString:@"注册"]) {
                    LoginRegisterManager *manager = [[LoginRegisterManager alloc] init];
                    manager.confirmVC = self;
                    [manager sendRequest:LOGINUSERREGISTER email:_emailStr pwd:self.pwdSubmitTF.text verdificationCode:nil];
                }
                else if ([_fromVCStr isEqualToString:@"密码找回"]) {
                    GetBackPwdManager *manager = [[GetBackPwdManager alloc] init];
                    manager.confirmVC = self;
                    [manager sendRequest:GETBACKUSERREGISTER email:_emailStr pwd:self.pwdTF.text verdificationCode:nil];
                }
            }
        }
        else {
            errorMessage = [NSString stringWithFormat:@"两次密码输入不一致"];
        }
    }
    
    if (errorMessage) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:errorMessage
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    }
}

- (void)receiveCompeleteRequest:(int)requestResult {
    if (requestResult == 1) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -4)] animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"注册失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 不能加空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return  NO;
    }
    return YES;
}

@end
