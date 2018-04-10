//
//  TopicItemCell.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/10.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleModel.h"
@class CircleItem;
@interface TopicItemCell : UITableViewCell
@property (nonatomic) CircleItem *circleItem;
- (void)setCircleItem:(CircleItem *)circleItem;
@end


@interface PhotoImageCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *photoImageView;
- (void)setImage:(NSString *)photoUrl;
@end
