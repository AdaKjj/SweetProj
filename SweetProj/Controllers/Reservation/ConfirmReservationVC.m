//
//  ConfirmReservationVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/31.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ConfirmReservationVC.h"
#import "UIImage+Addition.h"
#import "PayVC.h"

@interface ConfirmReservationVC ()

@end

@implementation ConfirmReservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.height.equalTo(self.view.height);
        make.width.equalTo(self.view.width);
    }];
    
    [self configConfirm];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
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

- (void)configConfirm {
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"confirmReservation"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(70);
        make.bottom.equalTo(30);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:systemFont(18)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = 10;
    confirmBtn.backgroundColor = SYSTEMCOLOR;
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-70);
        make.centerX.equalTo(0);
        make.height.equalTo(40);
        make.width.equalTo(280);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:systemFont(18)];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 10;
    cancelBtn.backgroundColor = SYSTEMCOLOR;
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmBtn.mas_bottom).inset(10);
        make.centerX.equalTo(0);
        make.height.equalTo(40);
        make.width.equalTo(280);
    }];
    
}

- (void)confirmBtnClicked {
    PayVC *vc = [[PayVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelBtnClicked {
    
}
@end
