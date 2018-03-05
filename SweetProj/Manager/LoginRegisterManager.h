//
//  LoginRegisterManager.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/22.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginVC.h"
#import "RegisterVC.h"
#import "ConfirmPwdVC.h"

typedef enum : NSUInteger {
    LOGINUSERLOGIN  = 1,
    LOGINCHECKOUTEMAIL,
    LOGINEMAILVER,
    LOGINUSERREGISTER,
} LoginRequestType;

@interface LoginRegisterManager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic) LoginVC *loginVC;
@property (nonatomic) RegisterVC *registerVC;
@property (nonatomic) ConfirmPwdVC *confirmVC;

- (void)sendRequest:(LoginRequestType)type email:(NSString *)email pwd:(NSString *)pwd verdificationCode:(NSString *)verCode;
@end
