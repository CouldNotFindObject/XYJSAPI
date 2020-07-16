//
//  NavigationComponent.m
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "NavigationComponent.h"
#import "WKContainerController.h"
//#import <WebKit/WebKit.h>

@implementation NavigationComponent
- (void)setTitle:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    self.container.navigationItem.title = [model.data valueForKey:@"title"];
    [model callSuccess:nil];
}
- (void)close:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if (self.container.navigationController) {
        dispatch_async(dispatch_get_main_queue(), ^{
			if (self.container.presentingViewController) {
				[self.container.presentingViewController dismissViewControllerAnimated:YES completion:nil];
			}else{
				[self.container.navigationController popViewControllerAnimated:YES];
			}
            [model callSuccess:nil];
        });
    } else {
        [model callFailre:nil];
    }
}
- (void)goBack:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if ([self.container isKindOfClass:[WKContainerController class]]) {
        WKWebView *webview = ((WKContainerController *)self.container).webView;
        if (webview.canGoBack) {
            [webview goBack];
            [model callSuccess:nil];
        } else {
            [self close:model];
        }
    }
}
- (void)hidden:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if (self.container.navigationController) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.container.navigationController setNavigationBarHidden:YES animated:YES];
            [model callSuccess:nil];
        });
    } else {
        [model callFailre:nil];
    }
}
- (void)show:(DispatcherModel *)model{
    NSLog(@"%@ %s",model.data,__func__);
    if (self.container.navigationController) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.container.navigationController setNavigationBarHidden:NO animated:YES];
            [model callSuccess:nil];
        });
    } else {
        [model callFailre:nil];
    }
}

@end
