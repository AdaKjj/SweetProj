//
//  GetTopicArr.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/20.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "GetTopicArr.h"

@implementation GetTopicArr

+ (NSMutableArray *)getInfo {
    
    NSMutableArray *fakeDatasource = [[NSMutableArray alloc]init];
    
    NSArray *array = @[
                       @{
                           @"name": @"第1个",
                           @"avatar": @"adtestsfour",
                           @"content": @"华丽的水晶灯投下淡淡的光，使整个餐厅显得优雅而静谧。柔和的萨克斯曲充溢着整个餐厅，如一股无形的烟雾在蔓延着，慢慢地慢慢地占据你的心灵，使你的心再也难以感到紧张和愤怒。玫瑰花散发出阵阵幽香，不浓亦不妖，只是若有若无地改变着你复杂的心情，使你的心湖平静得像一面明镜，没有丝毫的涟漪。彬彬有礼的侍应生，安静的客人，不时地小声说笑，环境宁静而美好.... ",
                           @"time":@"11/04",
                           @"imgs": @[@"text1",
                                      @"text2",
                                      @"text3"
                                      ],
                           @"likeNum":@"13",
                           @"level":@"7"
                           },
                       @{
                           @"name": @"第2个",
                           @"avatar": @"adtestsfour",
                           @"content": @"华丽的水晶灯投下淡淡的光，使整个餐厅显得优雅而静谧。柔和的萨克斯曲充溢着整个餐厅，如一股无形的烟雾在蔓延着，慢慢地慢慢地占据你的心灵，使你的心再也难以感到紧张和愤怒。 ",
                           @"time":@"11/06",
                           @"imgs": @[@"text1",
                                      @"text2"
                                      ],
                           @"likeNum":@"14",
                           @"level":@"6"
                           },
                       @{
                           @"name": @"第3个",
                           @"avatar": @"adtestsfour",
                           @"content": @"华丽的水晶灯投下淡淡的光，",
                           @"time":@"11/05",
                           @"imgs": @[@"text1",
                                      @"text2",
                                      @"text3",
                                      @"text4"
                                      ],
                           @"likeNum":@"15",
                           @"level":@"5"
                           },
                       ];
    [fakeDatasource addObjectsFromArray:array];
    return fakeDatasource;
}
@end
