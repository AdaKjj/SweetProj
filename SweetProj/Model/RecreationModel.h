//
//  RecreationModel.h
//  SweetProj
//
//  Created by 殷婕 on 2018/1/24.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "JSONModel.h"
@protocol OneRecreationModel
@end

@protocol AdUrlModel
@end

@interface OneRecreationModel : JSONModel

@property (assign, nonatomic) int mer_id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *classify;
@property (assign, nonatomic) int time;
@property (assign, nonatomic) int grade;
@property (assign, nonatomic) float longitude;
@property (assign, nonatomic) float latitude;
@property (strong, nonatomic) NSURL *pho_url;
@property (assign, nonatomic) int stars;
@property (assign, nonatomic) float distance;

@end


@interface RecreationModel : JSONModel

@property (strong, nonatomic) NSArray<OneRecreationModel> *recreation;

@end


@interface  FoodCollectionModel : JSONModel

@property (strong, nonatomic) NSArray<OneRecreationModel> *food;

@end



@interface AdUrlModel : JSONModel

@property (strong, nonatomic) NSURL *url;

@end

@interface AdvertisingModel :JSONModel

@property (strong, nonatomic) NSArray<AdUrlModel> *advertising;

@end
