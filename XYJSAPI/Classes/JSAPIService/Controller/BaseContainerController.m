//
//  BaseContainerController.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "BaseContainerController.h"
#import "ComponentDispatcher.h"
#import "PreLoadFilter.h"
@interface BaseContainerController ()<PreLoadFilterProtocol>
@property(nonatomic,strong)ComponentDispatcher * dispatcher;
@property(nonatomic,strong)PreLoadFilter * filter;
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
        _dispatcher = [ComponentDispatcher dispatcherWithContainer:self];
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
	if (self.isNewURLPage) {
		_filter = [PreLoadFilter filterWithContainer:self];
		_dispatcher = [ComponentDispatcher dispatcherWithContainer:self];
		[self registerHandler];
		[self registerCustomMethodWithBridge:self.bridge];
		[self reloadWebview];
		_currentRenderUrl = self.renderUrl;
	}
    //执行过滤
    [self.filter didFilter];
    if (_bridge) { return; }
    
    //初始化桥
    [self initWebViewJavascriptBridge];
    
    //注册桥方法
    [self registerHandler];
    
    //注册自定义桥方法
    [self registerCustomMethodWithBridge:self.bridge];
    
    //加载页面
    [self renderWeb];
	_currentRenderUrl = self.renderUrl;
}

- (BOOL)isNewURLPage{
	return ![_renderUrl isEqualToString:_currentRenderUrl];
}

- (void)reloadWebview{
	[self hidenErrorView];
	[self renderWeb];
}

- (void)hidenErrorView{
	
}

- (void)showErroView:(NSString *)reason{
	
}

- (void)preLoadCompleteFilter:(FilterModel *)filter{
	[self filterComplete:filter];
}

- (void)willPreLoadFilter:(FilterModel *)filter{
	[self willFilter:filter];
}

- (void)filterComplete:(FilterModel *)filter{
	
}

- (void)willFilter:(FilterModel *)filter{
	
}

- (void)registerCustomMethodWithBridge:(WebViewJavascriptBridge *)bridge{
    //注册自定义桥方法
    //子类需重写此方法 -- 可以同时注册多个
    
    /**
     注册自定义方法
     
     @param data 自定义方法名称
     @param responseCallback js端传递过来的参数
     @return js端传递回来的回调
     */
//    [bridge registerHandler:@"custom_jsCallNative_call" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"%@",data);//打印js传递过来的参数
//        NSDictionary * result = @{};//生成回调结果
//        responseCallback(result);//进行回调
//    }];
    
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
        return @"http://10.238.103.86:7999";
    }
    return _renderUrl;
}
@end
