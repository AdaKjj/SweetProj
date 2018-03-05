//
//  PersonalSettingsVC.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/19.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSettingsVC : UIViewController

@property (nonatomic) UIImageView   * avatarView;
@property (nonatomic) UILabel       * nameLabel;   // 昵称标签
@property (nonatomic) UILabel       * idLabel;     // 账号标签
@property (nonatomic) UILabel       * genderLabel; // 性别标签
@property (nonatomic) UILabel       * placeLabel;  // 地区标签
@property (nonatomic) NSString      * genderString;; // 性别标签

@end
