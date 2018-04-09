//
//  BaseContainerController.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
@interface BaseContainerController : UIViewController
<WKNavigationDelegate>
/**
 需要渲染的URL路径
 */
@property(nonatomic,copy)NSString * renderUrl;



/**
 更改当前容器横竖屏

 @param orientation 容器横竖屏参数
 */
- (void)changeDeviceOrientation:(UIInterfaceOrientation)orientation;

- (void)renderWeb;
- (id)getContainerWebView;
@end
