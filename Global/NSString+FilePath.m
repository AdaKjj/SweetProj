//
//  NSString+FilePath.m
//  DriveCar
//
//  Created by mhm on 9/10/15.
//  Copyright (c) 2015 Wenhua. All rights reserved.
//

#import "NSString+FilePath.h"

static NSString *s_documentDir = nil;

@implementation NSString (FilePath)
+ (NSString *)documentDirectory
{
    static NSString* s_documentDir;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    
    return s_documentDir;
}

+ (NSString *)repairServiceFilePath
{
    return [[NSString documentDirectory] stringByAppendingPathComponent:@"repair.plist"];
}

+ (NSString *)sonServiceFilePath
{
    return [[NSString documentDirectory] stringByAppendingPathComponent:@"son.plist"];
}

+ (NSString *)repairPeopleFilePath
{
    return [[NSString documentDirectory] stringByAppendingPathComponent:@"repairPeople.plist"];
}
@end
