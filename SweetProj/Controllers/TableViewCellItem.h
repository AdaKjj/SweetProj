//
//  TableItem.h
//  DriveCar
//
//  Created by mhm on 15/6/29.
//  Copyright (c) 2015年 Bwuni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewSection : NSObject
@property (nonatomic) NSString *sectionName;
@property (nonatomic) NSString *headerTitle;
@property (nonatomic) NSString *footerTitle;
@property (nonatomic) NSArray *itemArray;
- (instancetype)initWithArray:(NSArray*)itemArray;
@end

@interface TableViewCellItem : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *descript;
@property (nonatomic) NSString *imageName;
- (instancetype)initWithTitle:(NSString*)aTitle;
@end
