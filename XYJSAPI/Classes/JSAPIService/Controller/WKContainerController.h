//
//  WKContainerController.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "BaseContainerController.h"
#import <WebKit/WebKit.h>
@interface WKContainerController : BaseContainerController
<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong,readonly)WKWebView* webView;
@property(nonatomic,assign) BOOL displayProgressView;
@property (nonatomic, strong) UIProgressView *progressView;


@end
