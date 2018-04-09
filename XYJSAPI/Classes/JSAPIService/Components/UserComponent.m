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

- (void)get:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if ([GlobalDataService shardService].adAccount) {
        [model callSuccess:@{@"adAccount":[GlobalDataService shardService].adAccount}];
    } else {
        NSLog(@"adAccount的为nil");
    }
}
@end
