//
//  ColorUtil.m
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if([cString length]==3){
        
        NSString *c1 = [cString substringWithRange:NSMakeRange(0,1)];
        NSString *c2 = [cString substringWithRange:NSMakeRange(1,1)];
        NSString *c3 = [cString substringWithRange:NSMakeRange(2,1)];
        
        cString = [NSString stringWithFormat:@"%@%@%@%@%@%@",c1,c1,c2,c2,c3,c3,nil];
    }
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
