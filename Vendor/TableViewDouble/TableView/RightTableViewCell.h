//
//  RightTableViewCell.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@class ItemModel;

#define kCellIdentifier_Right @"RightTableViewCell"
typedef void (^OperationBlock) (NSInteger number,BOOL plus);

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) ItemModel *model;
@property (nonatomic) UIButton *minBtn;
@property (nonatomic) UIButton *addBtn;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic) int countt;

@property (nonatomic) UILabel *countLabel;


@property (nonatomic,copy) OperationBlock operationBlock;
@end
