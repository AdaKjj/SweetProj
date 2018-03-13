//
//  PreViewDDListManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/7.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodPreviewVC.h"
@interface PreViewDDListManager : NSObject

@property (nonatomic) FoodPreviewVC *foodPreviewVC;

- (void)sendRequestWithCity:(NSString *)city;
@end
