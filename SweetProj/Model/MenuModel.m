//
//  MenuModel.m
//  SweetProj
//
//  Created by 殷婕 on 2018/4/3.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MenuModel.h"

@implementation ItemModel

+ (JSONKeyMapper *)keyMapper{
    // 属性名作为key ,字典中的key名 作为 value
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"desc":@"description"}];
}

@end

@implementation ItemListModel
@end

@implementation MenuModel
@end


