//
//  ShopDetailManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/13.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodDetailVC.h"
@interface ShopDetailManager : NSObject

@property (nonatomic) FoodDetailVC *foodDetailVC;

- (void)sendRequestWithMerID:(NSString *)merID;

@end
