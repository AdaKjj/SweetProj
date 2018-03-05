//
//  TableItem.m
//  DriveCar
//
//  Created by mhm on 15/6/29.
//  Copyright (c) 2015年 Bwuni. All rights reserved.
//

#import "TableViewCellItem.h"

@implementation TableViewSection

- (instancetype)initWithArray:(NSArray*)itemArray
{
    self = [super init];
    if (self) {
        _itemArray = itemArray;
    }
    return self;

}

@end

@implementation TableViewCellItem

- (instancetype)initWithTitle:(NSString*)aTitle
{
    self = [super init];
    if (self) {
        _title = aTitle;
    }
    return self;
}

@end
