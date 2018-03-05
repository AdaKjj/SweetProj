//
//  Global.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#ifndef Global_h
#define Global_h

#import <UIKit/UIKit.h>

BOOL isValidEmail(NSString *candidate, NSString **errorString);
BOOL isValidPassword(NSString *candidate, NSString **errorString);
BOOL isValidPhoneNo(NSString *candidate, NSString **errorString);

#endif /* Global_h */
