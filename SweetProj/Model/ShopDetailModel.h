//
//  ShopDetailModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/13.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "JSONModel.h"

@protocol ShopDetails
@end

@interface ShopDetails : JSONModel

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *classify;
@property (nonatomic) NSString *introduce;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *business_hours;
@property (nonatomic) NSString *avecon;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *grade;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *latitude;
@property (nonatomic) BOOL status;
@property (nonatomic) BOOL reserve;

@end


@interface ShopDetailModel : JSONModel

@property (nonatomic) NSString *surface;
@property (nonatomic) NSArray *recommend;
@property (nonatomic) NSArray *environment;
@property (nonatomic) ShopDetails *shopdes;

@end
