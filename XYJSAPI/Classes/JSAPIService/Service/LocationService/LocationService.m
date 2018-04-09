//
//  LocationService.m
//  JSAPI
//
//  Created by 佟富贵 on 2018/4/3.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "LocationService.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MJExtension.h>

@interface LocationService ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) LoactionBlock locatingBlock;
@end

static LocationService *_mgr =nil;
@implementation LocationService

+ (void)configureAPIKey:(NSString *)apiKey{
    if ([apiKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    [AMapServices sharedServices].apiKey = (NSString *)apiKey;
}

+ (instancetype)sharedService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [LocationService new];
        [_mgr configLocationManager];
    });
    return _mgr;
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    //为了方便演示后台定位功能，这里设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.locatingBlock) {
        self.locatingBlock(error, nil, nil);
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (self.locatingBlock) {
        self.locatingBlock(nil, location, reGeocode);
    }
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeadin{
    //    NSLog(@"%@",newHeadin);
}
+ (void)startUpdatingLocation:(LoactionBlock)locating{
    //开始进行连续定位
    [LocationService sharedService].locatingBlock = locating;
    [[LocationService sharedService].locationManager startUpdatingLocation];
}
+ (void)singleRequestLocation:(LoactionBlock)locating{
    //开始进行单次请求地址
    [LocationService sharedService].locatingBlock = locating;
    [[LocationService sharedService].locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [_mgr amapLocationManager:nil didFailWithError:error];
        }
        [_mgr amapLocationManager:nil didUpdateLocation:location reGeocode:regeocode];
    }];
}

+ (void)stopUpdatingLocation{
    [[LocationService sharedService].locationManager stopUpdatingLocation];
}
@end
