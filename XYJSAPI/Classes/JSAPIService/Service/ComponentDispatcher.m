//
//  ComponentDispatcher.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "ComponentDispatcher.h"
#import "ComponentModel.h"
#import "StringUtil.h"
#import "BaseComponent.h"
#import "DispatcherModel.h"
#import <objc/message.h>
#import <MJExtension/MJExtension.h>

#define GGMsgSend(...) ((void (*)(void *, SEL,DispatcherModel *))objc_msgSend)(__VA_ARGS__)
#define GGMsgTarget(target) (__bridge void *)(target)

@interface ComponentDispatcher ()
@property(nonatomic,weak)BaseContainerController * container;
@property(nonatomic,strong)WebViewJavascriptBridge* bridge;
@property(nonatomic,strong)NSMutableDictionary * componentPool;
@property(nonatomic,strong)NSMutableDictionary * componentConfig;
@property(nonatomic,strong)NSArray<ComponentModel *> * componentConfigs;
@end
@implementation ComponentDispatcher

+ (instancetype)dispatcherWithContainer:(BaseContainerController *)container{
    ComponentDispatcher * dispatcher = [[self alloc]init];
    dispatcher.container = container;
    return dispatcher;
}

- (NSMutableDictionary *)componentPool{
    if (!_componentPool) {
        _componentPool = [NSMutableDictionary dictionary];
    }
    return _componentPool;
}

- (NSMutableDictionary *)componentConfig{
    if (!_componentConfig) {
        _componentConfig = [NSMutableDictionary dictionary];
    }
    return _componentConfig;
}

- (NSArray<ComponentModel *> *)componentConfigs{
    if (!_componentConfigs) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"XYJSAPIBundel" withExtension:@"bundle"];
        bundle = [NSBundle bundleWithURL:url];
        NSString *file = [bundle pathForResource:@"config.plist" ofType:nil];
        _componentConfigs = [ComponentModel mj_objectArrayWithFile:file];
    }
    return _componentConfigs;
}

- (void)registerHandlerWithBridge:(WebViewJavascriptBridge *)bridge{
    _bridge = bridge;
    for (ComponentModel * model in self.componentConfigs) {
        [bridge registerHandler:model.jsMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            [self dispatcherHandlerWithJsMethod:model.jsMethod andData:data andCallback:responseCallback];
        }];
        [self.componentConfig setValue:model forKey:model.jsMethod];
    }

}

//负责事件的分发
- (void)dispatcherHandlerWithJsMethod:(NSString *)jsMethod
                              andData:(id)data
                          andCallback:(WVJBResponseCallback)callback {
    id service = [self.componentPool valueForKey:jsMethod];
    ComponentModel * model = [self.componentConfig valueForKey:jsMethod];
    if (service == nil) {
        Class clazz = NSClassFromString(model.componentServiceClassName);
        service = [[clazz alloc]init];
        [service setValue:self.container forKey:@"container"];
    }
    
    SEL selector = NSSelectorFromString(model.componentServiceMethodName);
    __weak typeof(self)weakSelf = self;
    DispatcherModel * dispatcherModel = [[DispatcherModel alloc]initWithData:data
                                                          andSuccessCallback:^(id responseData) {
                                                              callback([weakSelf successResponse:responseData]);
    }
                                                           andFailreCallback:^(id responseData) {
                                                               callback([weakSelf failreResponse:responseData]);
    }
                                                           andCancelCallback:^(id responseData) {
                                                               callback([weakSelf cancelResponse:responseData]);
    }];
    //消息发送
    GGMsgSend(GGMsgTarget(service),selector,dispatcherModel);
}



- (id)successResponse:(id)data{
    //errorCode :0
    // {errorCode:0,
    //  result:{}}}
    return @{@"errorCode":@"0",
             @"result":[self getResultWithData:data]
             };
}

- (id)failreResponse:(id)data{
    //errorCode :1
    return @{@"errorCode":@"1",
             @"result":[self getResultWithData:data]};
}

- (id)cancelResponse:(id)data{
    //errorCode :-1
    return @{@"errorCode":@"-1",
             @"result":[self getResultWithData:data]};
}

- (id)getResultWithData:(id)data{
    id result = data;
    if(result == nil){
        result = @{};
    }
    return result;
}

@end
