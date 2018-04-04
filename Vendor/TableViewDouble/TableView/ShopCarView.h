//
//  ShopCarView.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/28.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"

typedef void (^ShopCarOperationBlock) (NSIndexPath *indexPath,BOOL plus);


@interface ShopCarView : UIView

@property (nonatomic) NSMutableArray<ShopCarModel *> *shopCarArr;

@property (nonatomic,copy) ShopCarOperationBlock operationBlock;

@end
