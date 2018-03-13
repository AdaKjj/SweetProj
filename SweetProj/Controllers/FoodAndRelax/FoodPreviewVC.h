//
//  FoodPreviewVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/27.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuModel.h"
@class DDMenuModel;

@interface FoodPreviewVC : UIViewController

@property (nonatomic) NSString *topicString;
@property (nonatomic) NSString *cityString;

@property (nonatomic) DDMenuModel *ddMenuModel;

- (void)getDDMenuArr:(NSDictionary *)valueDic;
@end
