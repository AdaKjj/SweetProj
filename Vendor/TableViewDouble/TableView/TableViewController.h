//
//  TableViewController.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
#import "MenuModel.h"

typedef void(^RemoveCellBlock)(ShopCarModel *model);

@class ShopCarModel;

@class MenuModel;
@class ItemModel;
@class ItemListModel;

@interface TableViewController : UIViewController

@property (nonatomic) ShopCarModel *shopCarModal;
@property (nonatomic) ItemModel *itemModel;
@property (nonatomic) ItemListModel *itemListModel;
@property (nonatomic) MenuModel *menuModel;
@property (nonatomic) NSString *merId;

//订单数据
@property (nonatomic,strong) NSMutableArray *ordersArray;
- (void)getMenuDic:(NSDictionary *)jsonDic;

@end
