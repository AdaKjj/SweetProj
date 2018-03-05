//
//  UITextFieldEx.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldEx : UITextField

- (BOOL)isValid:(NSString **)errorMsg;

@end

@interface UITextFieldEmail : UITextFieldEx
@end

@interface UITextFieldPwd : UITextFieldEx
@end

@interface UITextFieldPhone : UITextFieldEx
@end
