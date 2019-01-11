//
//  UserComponent.m
//  JSAPI
//
//  Created by 佟富贵 on 2018/3/21.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "UserComponent.h"
#import "DispatcherModel.h"
#import "GlobalDataService.h"

@implementation UserComponent

+ (void)setAdAccount:(NSString *)adAccount{
    [GlobalDataService shardService].adAccount = adAccount;
}
+ (void)setValue:(NSObject *)value forKey:(NSString *)key{
    [[GlobalDataService shardService].storeDic setValue:value forKey:key];
}
- (void)get:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if ([GlobalDataService shardService].adAccount || [GlobalDataService shardService].storeDic.allKeys.count > 0) {
        if ([GlobalDataService shardService].adAccount) {
            [[GlobalDataService shardService].storeDic setValue:[GlobalDataService shardService].adAccount forKey:@"adAccount"];
        }
        [model callSuccess:[GlobalDataService shardService].storeDic];
    } else {
        NSLog(@"adAccount的为nil");
        [model callFailre:@"数据为空"];
    }
}
@end
