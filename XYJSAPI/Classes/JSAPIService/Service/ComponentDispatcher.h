//
//  ComponentDispatcher.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//  负责分发方法调用

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"
#import "BaseContainerController.h"
@interface ComponentDispatcher : NSObject
- (void)registerHandlerWithBridge:(WebViewJavascriptBridge *)bridge;
+ (instancetype)dispatcherWithContainer:(BaseContainerController *)container;
@end
