//
//  GlobalDataService.m
//  JSAPI
//
//  Created by 佟富贵 on 2018/4/9.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "GlobalDataService.h"

static GlobalDataService *mgr = nil;

@implementation GlobalDataService

+ (instancetype)shardService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [GlobalDataService new];
        mgr.storeDic = [NSMutableDictionary dictionary];
    });
    return mgr;
}

@end
