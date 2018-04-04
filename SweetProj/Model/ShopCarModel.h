//
//  ShopCarModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/27.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject

@property(nonatomic) int orderid;
@property(nonatomic,copy) NSString *name;
@property(nonatomic) float min_price;

@property (nonatomic) NSInteger count;

@end
