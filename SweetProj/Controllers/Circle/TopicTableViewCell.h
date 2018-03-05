//
//  TopicTableViewCell.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/20.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicTableViewCell : UITableViewCell

@property (nonatomic) UIImageView *avatarImageView;

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UILabel *timeLabel;

@property (nonatomic) UILabel *descLabel;

@property (nonatomic) UIButton *locBtn;
@property (nonatomic) UIButton *likeCountBtn;

@property (nonatomic) int textHeight;

@property (nonatomic) UIImageView *backgroundImageView;

@end
