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
@class FilterModel;
@interface BaseContainerController : UIViewController<WKNavigationDelegate,WKUIDelegate>

/**
 需要渲染的URL路径
 */
@property(nonatomic,copy)NSString * renderUrl;

@property(nonatomic,copy,readonly)NSString *currentRenderUrl;
/**
 js桥
 */
@property(nonatomic,strong,readonly)WebViewJavascriptBridge* bridge;

@property (nonatomic, strong) WKWebView *webView;

/**
 更改当前容器横竖屏

 @param orientation 容器横竖屏参数
 */
- (void)changeDeviceOrientation:(UIInterfaceOrientation)orientation;
/**
 可以在此方法中自行注册
 */
- (void)registerCustomMethodWithBridge:(WebViewJavascriptBridge *)bridge;
- (void)renderWeb;
- (void)reloadWebview;
- (BOOL)isNewURLPage;
- (void)showErroView:(NSString *)reason;
- (void)hidenErrorView;
- (void)backToIndex;
- (void)filterComplete:(FilterModel *)filter;
- (void)willFilter:(FilterModel *)filter;
@end
