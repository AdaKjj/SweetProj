//
//  SessionManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/3.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SessionBlock)(BOOL isSuccess);

@interface SessionManager : NSObject

@property (nonatomic) SessionBlock sessionBlock;
- (void)reLogin;
@end
