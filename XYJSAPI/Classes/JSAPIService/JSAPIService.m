//
//  JSAPIService.m
//  JSAPI
//
//  Created by Nile on 2018/3/15.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "JSAPIService.h"
#import <UIKit/UIKit.h>
@implementation JSAPIService

+ (void)load{
    //更改UserAgent
    NSLog(@"JSAPIService Load");
    UIWebView *webView = [UIWebView new];
    NSString *originUA = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUA = [NSString stringWithFormat:@"%@ %@",originUA,@"XYApp(v/1.0)"];
    NSDictionary *dictionary = @{@"UserAgent":newUA};
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}



@end
