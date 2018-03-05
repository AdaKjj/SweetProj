//
//  PayVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/2/16.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "PayVC.h"
#import "UIImage+Addition.h"
#import "XLPaymentSuccessHUD.h"
#import "XLPaymentLoadingHUD.h"
#import "MainVC.h"

@interface PayVC ()

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"付款";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //隐藏支付完成动画
    [XLPaymentSuccessHUD hideIn:self.view];
    //显示支付中动画
    [XLPaymentLoadingHUD showIn:self.view];
    
    [self performSelector:@selector(payBtnClicked) withObject:nil afterDelay:3];
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:6];
}

- (void)payBtnClicked {
    //隐藏支付中成动画
    [XLPaymentLoadingHUD hideIn:self.view];
    //显示支付完成动画
    [XLPaymentSuccessHUD showIn:self.view];
}

- (void)dismissViewController {
    for (UIViewController *temp in self.navigationController.viewControllers)
    {
        if ([temp isKindOfClass:[MainVC class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
    }
   // [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
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

@end
