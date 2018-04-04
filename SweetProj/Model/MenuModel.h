//
//  MenuModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/3.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "JSONModel.h"

@protocol ItemModel
@end
@protocol ItemListModel
@end

@interface ItemModel :JSONModel

@property (nonatomic) int item_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *photo;
@property (nonatomic) float univalence;
@property (nonatomic) NSString<Optional> *stick_time;
@property (nonatomic) NSString<Optional> *desc;
@property (nonatomic) float discount_singe;
@property (nonatomic) float discount;
@property (nonatomic) float discount_result;

@property (nonatomic) NSNumber<Optional> *count;

@end


@interface ItemListModel : JSONModel

@property (nonatomic) int class_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSArray<ItemModel> *item;

@end


@interface MenuModel : JSONModel

@property (nonatomic) NSArray<ItemListModel> *item_list;
@property (nonatomic) NSString<Optional> *VIP_name;
@property (nonatomic) NSNumber<Optional> *vip_discount;

@end
