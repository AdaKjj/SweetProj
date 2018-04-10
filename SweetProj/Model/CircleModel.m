//
//  CircleModel.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/13.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "CircleModel.h"

@implementation CircleItem
+ (JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperForSnakeCase];
}
@end

@implementation CircleModel
+ (JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperForSnakeCase];
}
@end
