//
//  MainItemCell.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/19.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainItemCell : UICollectionViewCell

@property (nonatomic) UIImageView *storeImageView;
@property (nonatomic) UILabel *storNameLabel;
@property (nonatomic) UILabel *numOfCommentLabel;
@property (nonatomic) UILabel *typeLabel;
@property (nonatomic) UILabel *distanceLabel;

@property (nonatomic) int mer_id;

@property (nonatomic) UIColor *textColor;

@end
