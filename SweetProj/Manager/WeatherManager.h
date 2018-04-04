//
//  WeatherManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/14.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainVC.h"

@interface WeatherManager : NSObject

@property (nonatomic) MainVC *mainVC;

- (void)sendRequestWithCity:(NSString *)city;

@end
