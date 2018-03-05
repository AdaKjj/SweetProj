//
//  sessionManager.h
//  明秀山庄物业管理
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 mac. All rights reserved.
//
#define USER_RELOGIN   0
#define TEST_URL       1
#import <UIKit/UIKit.h>

@interface sessionManager : UIView
- (void)reLogin:(NSString *)emailString
            pwdString:(NSString *)pwdString;

- (void)submitSession:(NSString *)sessionString;
@property (strong, nonatomic) NSMutableData *receiveData;
@property (strong, nonatomic) NSString *receiveStr;
@property (strong, nonatomic) NSString *string;
/*- (void)sendRequest:(NSInteger)type
              email:(NSString *)email
             verify:(NSString *)verify
           password:(NSString *)password;*/
@end
