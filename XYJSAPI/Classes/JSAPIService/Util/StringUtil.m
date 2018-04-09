//
//  StringUtil.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil
+ (BOOL)isEmpty:(NSString *)str{
    return
    (str == nil) ||
    [str isEqual:[NSNull null]] ||
    ([[str stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0);
}
@end

