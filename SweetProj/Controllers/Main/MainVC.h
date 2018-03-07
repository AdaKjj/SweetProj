//
//  MainVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecreationModel.h"
@class FoodCollectionModel;
@class RecreationModel;
@class AdvertisingModel;
@class AdUrlModel;
@class OneRecreationModel;

@interface MainVC : UIViewController

@property (nonatomic) FoodCollectionModel *foodModel;
@property (nonatomic) RecreationModel *recreationModel;
@property (nonatomic) AdvertisingModel *advertisingModel;
@property (nonatomic) AdUrlModel *adUrlModel;
@property (nonatomic) OneRecreationModel *oneRecreationModel;

- (void)getAdArr:(NSDictionary *)jsonDic;

@end
