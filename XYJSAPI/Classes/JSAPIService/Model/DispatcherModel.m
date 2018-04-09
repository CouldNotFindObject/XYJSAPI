//
//  DispatcherModel.m
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "DispatcherModel.h"
NSString *const SuccessMsg         = @"成功";//（立即体验）
NSString *const CancelMsg          = @"取消";
NSString *const FailreMsg           = @"失败";

@implementation DispatcherModel
- (instancetype)initWithData:(id)data
          andSuccessCallback:(GGJBResponseSuccessCallback)successCallback
           andFailreCallback:(GGJBResponseFailreCallback)failreCallback
           andCancelCallback:(GGJBResponseCancelCallback)cancelCallback{
    if(self = [super init]){
        self.successCallback = successCallback;
        self.failreCallback = failreCallback;
        self.cancelCallback = cancelCallback;
        self.data = data;
    }
    return self;
}

- (void)callSuccess:(id)msg{
    if (self.successCallback) {
        if (msg) {
            self.successCallback(msg);
        } else {
            self.successCallback(SuccessMsg);
        }
        [self p_cleanCallBack];
    } else {
        NSLog(@"暂无成功回调");
    }
}
- (void)callFailre:(id)msg{
    if (self.failreCallback) {
        if (msg) {
            self.failreCallback(msg);
        } else {
            self.failreCallback(FailreMsg);
        }
        [self p_cleanCallBack];
    } else {
        NSLog(@"暂无失败回调");
    }
}
- (void)callCancel:(id)msg{
    if (self.cancelCallback) {
        if (msg) {
            self.cancelCallback(msg);
        } else {
            self.cancelCallback(CancelMsg);
        }
        [self p_cleanCallBack];
    } else {
        NSLog(@"暂无取消回调");
    }
}
- (void)p_cleanCallBack{
    self.successCallback = nil;
    self.failreCallback = nil;
    self.cancelCallback = nil;
}
- (void)dealloc{
    NSLog(@"%s 释放",__func__);
}
@end
