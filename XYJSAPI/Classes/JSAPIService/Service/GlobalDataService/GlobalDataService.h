//
//  GlobalDataService.h
//  JSAPI
//
//  Created by 佟富贵 on 2018/4/9.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataService : NSObject
@property (nonatomic, copy) NSString *adAccount;
+ (instancetype)shardService;
@end
