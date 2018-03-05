//
//  ConfirmPwdVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPwdVC : UIViewController

@property (nonatomic) NSString *emailStr;
@property (nonatomic) NSString *fromVCStr;

- (void)receiveCompeleteRequest:(int)requestResult;
@end
