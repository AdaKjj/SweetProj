//
//  NSString+FilePath.h
//  DriveCar
//
//  Created by mhm on 9/10/15.
//  Copyright (c) 2015 Wenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FilePath)

+ (NSString *)documentDirectory;
+ (NSString *)repairServiceFilePath;
+ (NSString *)sonServiceFilePath;
+ (NSString *)repairPeopleFilePath;
@end
