//
//  ShopCarCell.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/28.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCarModel;

typedef void (^OperationBlock) (NSIndexPath *oriIndexPath,BOOL plus);

@interface ShopCarCell : UITableViewCell

@property (nonatomic) NSString *foodId;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *countLabel;
@property (nonatomic) UILabel *price;
@property (nonatomic) UIButton *addBtn;
@property (nonatomic) UIButton *minBtn;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) int count;

@property (nonatomic) ShopCarModel *model;

@property (nonatomic,copy) OperationBlock operationBlock;
@end
