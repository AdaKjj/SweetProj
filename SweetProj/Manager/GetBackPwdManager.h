//
//  GetBackPwdManager.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/28.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterVC.h"
#import "ConfirmPwdVC.h"
typedef enum : NSUInteger {
    GETBACKCHECKOUTEMAIL = 1,
    GETBACKEMAILVER,
    GETBACKUSERREGISTER,
} GetBackRequestType;

@interface GetBackPwdManager : NSObject

@property (nonatomic) RegisterVC *registerVC;
@property (nonatomic) ConfirmPwdVC *confirmVC;


- (void)sendRequest:(GetBackRequestType)type email:(NSString *)email pwd:(NSString *)pwd verdificationCode:(NSString *)verCode;

@end
