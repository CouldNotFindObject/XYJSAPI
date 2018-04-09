//
//  LocationService.h
//  JSAPI
//
//  Created by 佟富贵 on 2018/4/3.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void(^LoactionBlock)(NSError *error,CLLocation *location,AMapLocationReGeocode *reGeocode);

@interface LocationService : NSObject
/**
 首先设置一下apikey,这个需要跟bundleID绑定
 网址 http://lbs.amap.com/dev/key/app
 需要info.plist需要把相关定位打开,capability里的 background mode里的location需要打钩
 然后定位就可以,在前台和后台都可以定位
 */
+ (void)configureAPIKey:(NSString *)apiKey;
+ (void)singleRequestLocation:(LoactionBlock)locating;
+ (void)startUpdatingLocation:(LoactionBlock)locating;
+ (void)stopUpdatingLocation;
@end
