//
//  FilterModel.m
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "FilterModel.h"
#import "StringUtil.h"

@implementation FilterModel

- (instancetype)initWithUrl:(NSString *)url{
    if (self = [super init]) {
        if ([StringUtil isEmpty:url]) {
            return self;
        }
        NSString * tmpStr = url;
        NSArray * tmpArr = [tmpStr componentsSeparatedByString:@"?"];
        NSString * pramaStr = [tmpArr lastObject];
        NSArray * parmaArr = [pramaStr componentsSeparatedByString:@"&"];
        for (NSString * str in parmaArr) {
            NSArray * keyAndValue = [str componentsSeparatedByString:@"="];
            if (keyAndValue.count == 2) {
                [self setValue:[keyAndValue lastObject] forKey:[keyAndValue firstObject]];
            } else if (keyAndValue.count > 2) {
                NSMutableString *tmpValue = [NSMutableString string];
                [keyAndValue enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx > 1) {
                        [tmpValue appendFormat:@"=%@",obj];
                    } else if (idx == 1){
                        [tmpValue appendString:obj];
                    }
                }];
                [self setValue:tmpValue forKey:[keyAndValue firstObject]];
            }
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s RegisterOCToJSModel发现UndefinedKey:%@,value:%@",__func__,key,value);
}
- (void)setXy_nav_show:(NSString *)xy_nav_show{
    _xy_nav_show = xy_nav_show.lowercaseString;
}

@end
