//
//  LocationComponent.m
//  JSAPI
//
//  Created by 佟富贵 on 2018/4/3.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "LocationComponent.h"
#import "DispatcherModel.h"
#import "LocationService.h"
#import "JSBLocation.h"
#import <MJExtension.h>

@implementation LocationComponent
- (void)getLocation:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    [LocationService singleRequestLocation:^(NSError *error, CLLocation *location, AMapLocationReGeocode *reGeocode) {
        if (error) {
            [model callFailre:[error mj_JSONObject]];
            return ;
        }
        JSBLocation *jsLocation = [[JSBLocation alloc] initWithLocation:location reGeocode:reGeocode];
        [model callSuccess:[jsLocation mj_keyValues]];
    }];
}
@end
