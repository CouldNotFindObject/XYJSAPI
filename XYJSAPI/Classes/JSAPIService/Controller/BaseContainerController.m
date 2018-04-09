//
//  BaseContainerController.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "BaseContainerController.h"
#import "PreLoadFilter.h"

#import "ComponentDispatcher.h"
@interface BaseContainerController ()
@property(nonatomic,strong)PreLoadFilter * filter;
@property(nonatomic,strong)ComponentDispatcher * dispatcher;
@property(nonatomic,strong)WebViewJavascriptBridge* bridge;
@end

@implementation BaseContainerController

- (PreLoadFilter *)filter{
    if (!_filter) {
        _filter = [PreLoadFilter filterWithContainer:self];
    }
    return _filter;
}

- (ComponentDispatcher *)dispatcher{
    if (!_dispatcher) {
        _dispatcher = [ComponentDispatcher dispatcherWithContainer:self];;
    }
    return _dispatcher;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    //执行过滤
    [self.filter didFilter];
    if (_bridge) { return; }
    
    //初始化桥
    [self initWebViewJavascriptBridge];
    
    //注册桥方法
    [self registerHandler];
    
    //加载页面
    [self renderWeb];
    
}



- (void)changeDeviceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)registerHandler{
    [self.dispatcher registerHandlerWithBridge:self.bridge];
}

- (void)renderWeb{
    NSAssert(0, @"子类需重写该方法");
}

- (void)initWebViewJavascriptBridge{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:[self getContainerWebView]];
    [_bridge setWebViewDelegate:self];
}

- (id)getContainerWebView{
    NSAssert(0, @"子类需重写该方法");
    return nil;
}
- (void)js_callBackButton{
    [_bridge callHandler:@"backbutton"];
}
- (void)js_callOnline{
    [_bridge callHandler:@"online"];
}
- (void)js_callOffline{
    [_bridge callHandler:@"offline"];
}
- (void)js_callPause{
    [_bridge callHandler:@"pause"];
}
- (void)js_callResume{
    [_bridge callHandler:@"resume"];
}

- (void)backToIndex{
    [self js_callBackButton];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *)renderUrl{
    if (!_renderUrl) {
        return @"http://10.238.103.86:7999?xy_orientation=landscape";
    }
    return _renderUrl;
}
@end
