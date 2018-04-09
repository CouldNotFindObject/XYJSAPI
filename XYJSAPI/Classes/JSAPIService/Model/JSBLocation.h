//
//  JSBLocation.h
//  1123
//
//  Created by 佟富贵 on 2018/4/3.
//  Copyright © 2018年 pcitc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface JSBLocation : NSObject

@property (nonatomic, copy) NSString *aoiname;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, assign) NSTimeInterval time;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *street;

@property (nonatomic, assign) NSInteger speed;

@property (nonatomic, assign) CGFloat lon;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *adcode;

@property (nonatomic, assign) NSInteger bearing;

@property (nonatomic, copy) NSString *poiname;

@property (nonatomic, assign) NSInteger altitude;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, assign) NSInteger accuracy;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, copy) NSString *citycode;

@property (nonatomic, copy) NSString *address;

- (instancetype)initWithLocation:(CLLocation*)location reGeocode:(AMapLocationReGeocode*)reGeocode;

@end
