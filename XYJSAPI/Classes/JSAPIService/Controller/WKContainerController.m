//
//  WKContainerController.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "WKContainerController.h"
#import "WebViewJavascriptBridge.h"
#import "LocationService.h"

@interface WKContainerController ()
//@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *errView;
@end

@implementation WKContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view insertSubview:_webView belowSubview:self.progressView];
    
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (id)getContainerWebView{
    return self.webView;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
	[self hidenErrorView];
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(110, 400, 100, 35);
    reloadButton.titleLabel.font = font;
}

- (void)renderWeb{
    [self loadURL:[NSURL URLWithString:self.renderUrl]];
}

#pragma mark - WKWebView代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    if(![self externalAppRequiredToOpenURL:URL]) {
        if(!navigationAction.targetFrame) {
            [self loadURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    else if([[UIApplication sharedApplication] canOpenURL:URL]) {
//        [self launchExternalAppWithURL:URL];
        NSLog(@"将要打开其他的app");
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}
- (void)loadRequest:(NSURLRequest *)request {
    if(self.webView) {
        [self.webView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.4f delay:0.4f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    [self.progressView setProgress:1 animated:NO];
    [self showErroView:error.localizedDescription];
}

- (void)showErroView:(NSString *)reason{
	self.webView.hidden = YES;
    if (!_errView) {
        _errView = [[UIView alloc] initWithFrame:self.webView.bounds];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        backBtn.frame = CGRectMake(screenWidth/3, 100, 100, 100);
        [backBtn addTarget:self action:@selector(backToIndex) forControlEvents:(UIControlEventTouchUpInside)];
        [_errView addSubview:backBtn];
        
        UIButton *retryBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [retryBtn setTitle:@"重试" forState:(UIControlStateNormal)];
        retryBtn.frame = CGRectMake(screenWidth/3 * 2, 100, 100, 100);
        [retryBtn addTarget:self action:@selector(reloadWebview) forControlEvents:(UIControlEventTouchUpInside)];
        [_errView addSubview:retryBtn];
        
        UILabel *reasonLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, screenWidth-20, screenHeight/2))];
        reasonLab.numberOfLines = 0;
        reasonLab.text = reason;
        reasonLab.center = CGPointMake(screenWidth/2, screenHeight/2);
        [reasonLab sizeToFit];
        [_errView addSubview:reasonLab];
        [self.view insertSubview:_errView aboveSubview:_errView];
    } else {
        _errView.alpha = 1;
    }
}

- (void)hidenErrorView{
	self.errView.alpha = 0;
	self.webView.hidden = NO;
}

- (UIProgressView *)progressView{
    if(!_progressView)
    {
        CGFloat y = self.navigationController ? self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y  : 0;
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, y, self.webView.bounds.size.width, 0)];
        _progressView.tintColor = [UIColor orangeColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:_progressView];
        [_progressView setProgress:0];
    }
    return _progressView;
}

// 取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _progressView.frame = CGRectMake(0, self.webView.bounds.origin.y, self.webView.bounds.size.width, 0);
}

#pragma mark - js用的alert弹出问题
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
