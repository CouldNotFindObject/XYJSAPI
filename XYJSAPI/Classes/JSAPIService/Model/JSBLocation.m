//
//  JSBLocation.m
//  1123
//
//  Created by 佟富贵 on 2018/4/3.
//  Copyright © 2018年 pcitc. All rights reserved.
//

#import "JSBLocation.h"

@implementation JSBLocation
- (instancetype)initWithLocation:(CLLocation*)location reGeocode:(AMapLocationReGeocode*)reGeocode{
    self = [self init];
    if (self) {
        self.altitude = location.altitude;
        self.speed = location.speed;
        self.bearing = location.course;
        self.citycode = reGeocode.citycode;
        self.adcode = reGeocode.adcode;
        self.country = reGeocode.country;
        self.province = reGeocode.province;
        self.city = reGeocode.city;
        self.district = reGeocode.district;
        self.street = reGeocode.street;
        self.number = reGeocode.number;
        self.poiname = reGeocode.POIName;
        self.aoiname = reGeocode.AOIName;
        self.address = reGeocode.formattedAddress;
        self.time = location.timestamp.timeIntervalSince1970;
        self.lon = location.coordinate.longitude;
        self.lat = location.coordinate.latitude;
    }
    return self;
}
@end
