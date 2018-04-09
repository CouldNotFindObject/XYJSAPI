//
//  ViewController.m
//  JSAPI
//
//  Created by Neo on 2018/3/15.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "JSABaseWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface JSABaseWebViewController ()

@property WebViewJavascriptBridge* bridge;
@end

@implementation JSABaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"ui.navigation.setTitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

- (void)renderButtons:(UIWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:11.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(0, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(90, 400, 100, 35);
    reloadButton.titleLabel.font = font;
    
    UIButton* safetyTimeoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [safetyTimeoutButton setTitle:@"Disable safety timeout" forState:UIControlStateNormal];
    [safetyTimeoutButton addTarget:self action:@selector(disableSafetyTimeout) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:safetyTimeoutButton aboveSubview:webView];
    safetyTimeoutButton.frame = CGRectMake(190, 400, 120, 35);
    safetyTimeoutButton.titleLabel.font = font;
}

- (void)disableSafetyTimeout {
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}

- (void)callHandler:(id)sender {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSURL *baseURL = [NSURL URLWithString:@"http://10.238.103.86:7999"];
    [webView loadRequest:[NSURLRequest requestWithURL:baseURL]];
    
}

@end
