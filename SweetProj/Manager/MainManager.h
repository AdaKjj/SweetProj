//
//  MainManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/1/24.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainVC.h"
@interface MainManager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic) MainVC *mainVC;

- (void)sendRequestWithLong:(NSString *)lon lat:(NSString *)lat;

@end
