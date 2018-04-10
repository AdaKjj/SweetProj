//
//  ConfirmTBCell.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/9.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCarModel;

@interface ConfirmTBCell : UITableViewCell
@property (nonatomic) ShopCarModel *model;
@end


@interface ConfirmTBHeader : UITableViewHeaderFooterView
@property (nonatomic) UILabel *seat;
@end


@interface ConfirmTBFooter : UITableViewHeaderFooterView
@property (nonatomic) UILabel *time;
@property (nonatomic) UILabel *price;
@end
