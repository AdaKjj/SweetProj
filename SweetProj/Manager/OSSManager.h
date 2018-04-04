//
//  OSSManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/4.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSSSTSModel.h"

typedef void(^DownloadBlock)(NSData *data);

@class OSSSTSModel;

@interface OSSManager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic) OSSSTSModel *ossModel;
@property (nonatomic) DownloadBlock downloadBlock;

- (void)uploadImage:(UIImage *)image;
- (void)downloadImageWithName:(NSString *)name;

@end
