//
//  CircleModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/3/13.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "JSONModel.h"

@protocol CircleItem
@end

@interface CircleItem : JSONModel
@property (nonatomic) NSString *circleId;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *merId;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *createTime;
@property (nonatomic) NSString *likeNum;
@property (nonatomic) NSString *nikcname;
@property (nonatomic) NSString *exp;
@property (nonatomic) NSString *relationSign;
@property (nonatomic) NSString *merName;
@property (nonatomic) NSArray<NSString *> *photoUrl;
@property (nonatomic) NSString *commentNum;
@end

@interface CircleModel : JSONModel
@property (nonatomic) NSArray<CircleItem> *circleList;

@end
