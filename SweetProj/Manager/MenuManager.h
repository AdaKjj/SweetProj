//
//  MenuManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/3.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewController.h"
#import "SessionManager.h"

@interface MenuManager : NSObject

@property (nonatomic) TableViewController *tbVC;
@property (nonatomic) NSString *merid;
- (void)sendRequestWithMerid:(NSString *)merid;
@end
