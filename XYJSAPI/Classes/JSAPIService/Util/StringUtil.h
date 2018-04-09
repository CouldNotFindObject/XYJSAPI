//
//  StringUtil.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject


/**
 检查字符串是否为空字符串,nil,

 @param str 要检查的字符串
 @return YES -- 是空字符串或nil NO -- 非空字符串或nil
 */
+ (BOOL)isEmpty:(NSString *)str;

@end
