//
//  Global.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

// 邮箱有效性验证
BOOL isValidEmail(NSString *candidate, NSString **errorString)
{
    if (candidate.length == 0) {
        if (errorString) {
            *errorString = @"请输入邮箱";
        }
        return NO;
    }
    else if (candidate.length > 33) {
        if (errorString) {
            *errorString = @"邮箱名称过长";
        }
        return NO;
    }
    //邮箱的正则表达式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailTest evaluateWithObject:candidate]) {
        if (errorString) {
            *errorString = @"邮箱格式不正确";
        }
        return NO;
    }
    
    return YES;
}

// 密码有效性验证
BOOL isValidPassword(NSString *candidate, NSString **errorString)
{
    if (candidate.length == 0) {
        if (errorString) {
            *errorString = @"请输入密码";
        }
        return NO;
    }
    
    NSString *pwdRegex = @"((?=.*\\d)(?=.*[a-zA-Z]).{6,16})";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
    if (![predicate evaluateWithObject:candidate]) {
        if (errorString) {
            *errorString = @"密码必须同时包含数字和字母，\n并且长度不少于6位";
        }
        
        return NO;
    }
    return YES;
}

// 号码有效性验证
BOOL isValidPhoneNo(NSString *candidate, NSString **errorString)
{
    if (candidate.length == 0) {
        if (errorString) {
            *errorString = @"请输入手机号";
        }
        return NO;
    }
    else {
        NSString *phoneRegex = @"(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        if (![predicate evaluateWithObject:candidate]) {
            if (errorString) {
                *errorString = @"请输入正确的手机号";
            }
            return NO;
        }
    }
    return YES;
}
