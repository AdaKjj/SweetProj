//
//  OSSSTSModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/4.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "JSONModel.h"

@interface OSSSTSModel : JSONModel

@property (nonatomic) NSString *AccessKeySecret;
@property (nonatomic) NSString *AccessKeyId;
@property (nonatomic) NSString *Expiration;
@property (nonatomic) NSString *SecurityToken;

@end
