//
//  RegisterVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "RegisterVC.h"
#import "ConfirmPwdVC.h"
#import "LoginRegisterManager.h"
#import "GetBackPwdManager.h"
#import "UITextFieldEx.h"
#import "UIImage+Addition.h"

@interface RegisterVC ()<UITextFieldDelegate>

@property (nonatomic) UIImageView *bgImageView;
@property (nonatomic) UIImageView *registerLogo;

@property (nonatomic) UITextFieldEmail *emailTF;
@property (nonatomic) UITextField *verificationCodeTF;

@property (nonatomic) UIButton *nextStepBtn;

@end

@implementation RegisterVC

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
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    
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
    emailImageView.image = [UIImage imageNamed:@"user"];
    emailImageView.contentMode = UIViewContentModeScaleAspectFit;
    _emailTF = [[UITextFieldEmail alloc] init];
    _emailTF.borderStyle = UITextBorderStyleNone;
    _emailTF.textColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1];
    _emailTF.backgroundColor = [UIColor clearColor];
    _emailTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮箱地址"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1]}];
    _emailTF.layer.borderWidth = 2.0f;
    _emailTF.layer.cornerRadius = 20;
    _emailTF.layer.borderColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1].CGColor;
    _emailTF.clearButtonMode = UITextFieldViewModeAlways;
    _emailTF.leftView = emailImageView;
    _emailTF.leftViewMode = UITextFieldViewModeAlways;
    _emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:_emailTF];
    [_emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_registerLogo.mas_bottom).inset(60);
        make.height.equalTo(40);
        make.width.equalTo(300);
    }];
    _emailTF.delegate = self;
    
    UIImageView *VerificationCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 26)];
    VerificationCodeImageView.image = [UIImage imageNamed:@"pwd"];
    VerificationCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _verificationCodeTF = [[UITextField alloc] init];
    _verificationCodeTF.borderStyle = UITextBorderStyleNone;
    _verificationCodeTF.textColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1];
    _verificationCodeTF.backgroundColor = [UIColor clearColor];
    _verificationCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                                attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1]}];
    _verificationCodeTF.layer.borderWidth = 2.0f;
    _verificationCodeTF.layer.cornerRadius = 20;
    _verificationCodeTF.layer.borderColor = [UIColor colorWithRed:155/255.0 green:175/255.0 blue:182/255.0 alpha:1].CGColor;
    _verificationCodeTF.clearButtonMode = UITextFieldViewModeAlways;
    _verificationCodeTF.leftView = VerificationCodeImageView;
    _verificationCodeTF.leftViewMode = UITextFieldViewModeAlways;
    _verificationCodeTF.keyboardType = UIKeyboardTypeASCIICapable;
    _verificationCodeTF.secureTextEntry = YES;
    
    UIButton *getVerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getVerBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerBtn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [getVerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [getVerBtn addTarget:self action:@selector(getVerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    getVerBtn.frame = CGRectMake(0, 0, 100, 25);
    _verificationCodeTF.rightView = getVerBtn;
    _verificationCodeTF.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_verificationCodeTF];
    [_verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_emailTF.mas_bottom).inset(20);
        make.height.equalTo(40);
        make.width.equalTo(300);
    }];
    _verificationCodeTF.delegate = self;
    
    _nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStepBtn setTitleColor:[UIColor blackColor]
                       forState:UIControlStateNormal];
    [_nextStepBtn setBackgroundColor:[UIColor whiteColor]];
    _nextStepBtn.layer.cornerRadius = 20;
    [_nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_nextStepBtn addTarget:self action:@selector(nextStepClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepBtn];
    [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_verificationCodeTF.mas_bottom).inset(30);
        make.height.equalTo(40);
        make.width.equalTo(150);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)getVerBtnClicked {
    NSString *errorMessage;
    if ([_emailTF isValid:&errorMessage]) {
        if ([_fromVCStr isEqualToString:@"注册"]) {
            LoginRegisterManager *manager = [[LoginRegisterManager alloc] init];
            manager.registerVC = self;
            [manager sendRequest:LOGINCHECKOUTEMAIL email:self.emailTF.text pwd:nil verdificationCode:nil];
        }
        else if ([_fromVCStr isEqualToString:@"密码找回"]) {
            GetBackPwdManager *manager = [[GetBackPwdManager alloc] init];
            manager.registerVC = self;
            [manager sendRequest:GETBACKCHECKOUTEMAIL email:self.emailTF.text pwd:nil verdificationCode:nil];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)backBtnPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStepClicked {
    if ([_fromVCStr isEqualToString:@"注册"]) {
        LoginRegisterManager *manager = [[LoginRegisterManager alloc] init];
        manager.registerVC = self;
        [manager sendRequest:LOGINEMAILVER email:self.emailTF.text pwd:nil verdificationCode:_verificationCodeTF.text];
    }
    else if ([_fromVCStr isEqualToString:@"密码找回"]) {
        GetBackPwdManager *manager = [[GetBackPwdManager alloc] init];
        manager.registerVC = self;
        [manager sendRequest:GETBACKEMAILVER email:self.emailTF.text pwd:nil verdificationCode:_verificationCodeTF.text];
    }

}

- (void)receiveSendEmailRequest:(int)requestResult {
    NSString *messageStr = nil;
    switch (requestResult) {
        case 0:
            messageStr = @"请前往邮箱查看验证码";
            break;
        case 1:
            messageStr = @"验证码请求失败";
            break;
        case 2:
            messageStr = @"验证码发送频率过快，请稍后再试";
            break;
        case 3:
            messageStr = @"该邮箱已被注册";
            break;
        default:
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:messageStr
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)receiveSendEmailVerRequest:(int)requestResult {
    NSString *messageStr = nil;
    switch (requestResult) {
        case 0: {
            ConfirmPwdVC *confirmVC = [ConfirmPwdVC new];
            confirmVC.emailStr = self.emailTF.text;
            confirmVC.fromVCStr = _fromVCStr;
            [self.navigationController pushViewController:confirmVC animated:YES];
            return;
            break;
        }
        case 1:
            messageStr = @"验证码错误";
            break;
        case 3:
            messageStr = @"验证码过期，已发送新验证码至邮箱";
            break;
        case 5:
            messageStr = @"请输入正确的邮箱";
            break;
        default:
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:messageStr
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
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
