//
//  FoodDetailVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/27.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@class ShopDetailModel;

@interface FoodDetailVC : UIViewController

@property (nonatomic) ShopDetailModel *shopDetailModel;
@property (nonatomic) int mer_id;

- (void)getShopDetail:(NSDictionary *)valueDic;
- (void)getCircleArr:(NSDictionary *)valueDic;

@end
