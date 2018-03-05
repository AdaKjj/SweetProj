//
//  UITextFieldEx.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "UITextFieldEx.h"
#import "Global.h"

@implementation UITextFieldEx

- (BOOL) isValid:(NSString **)errorMsg
{
    return YES;
}

@end




@implementation UITextFieldEmail : UITextFieldEx
// 禁止粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    
    return self;
}

- (BOOL)isValid:(NSString **)errorMsg
{
    return isValidEmail(self.text, errorMsg);
}

- (NSInteger)maxLength
{
    return 33;
}

- (BOOL)shouldAllowString:(NSString *)string
{
    return YES;
}
@end



@implementation UITextFieldPwd : UITextFieldEx
// 禁止粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.secureTextEntry = YES;
    }
    
    return self;
}

- (BOOL)isValid:(NSString **)errorMsg
{
    return isValidPassword(self.text, errorMsg);
}

- (NSInteger)maxLength
{
    return 17;
}

- (BOOL)shouldAllowString:(NSString *)string
{
    // 只能支持字母和数字
    NSCharacterSet * set = [NSCharacterSet alphanumericCharacterSet];
    NSRange range1 = [string rangeOfCharacterFromSet:set];
    return range1.location != NSNotFound;
}

@end

@implementation UITextFieldPhone : UITextFieldEx

// 禁止粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return self;
}

- (BOOL)isValid:(NSString **)errorMsg
{
    return isValidPhoneNo(self.text, errorMsg);
}

- (NSInteger)maxLength
{
    return 11;
}

- (BOOL)shouldAllowString:(NSString *)string
{
    return YES;
}

@end

