//
//  RegisterVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : UIViewController

@property (nonatomic) NSString *fromVCStr;

- (void)receiveSendEmailRequest:(int)requestResult;
- (void)receiveSendEmailVerRequest:(int)requestResult;
@end
