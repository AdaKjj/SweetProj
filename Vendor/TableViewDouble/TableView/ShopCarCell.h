//
//  ShopCarCell.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/28.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShopCarOperationBlock) (NSString *foodId,BOOL plus);

@interface ShopCarCell : UITableViewCell

@property (nonatomic) NSString *foodId;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *countLabel;
@property (nonatomic) UILabel *price;
@property (nonatomic) UIButton *addBtn;
@property (nonatomic) UIButton *minBtn;

@property (nonatomic) int count;

@property (nonatomic,copy) ShopCarOperationBlock operationBlock;
@end
