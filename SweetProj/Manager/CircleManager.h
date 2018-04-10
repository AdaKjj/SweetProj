//
//  CircleManager.h
//  SweetProj
//
//  Created by 殷婕 on 2018/4/10.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicVC.h"
@interface CircleManager : NSObject
@property (nonatomic) TopicVC *topicVC;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *start;
- (void)sendRequestWithType:(NSString *)type andStart:(NSString *)start;
@end
