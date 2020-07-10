//
//  PreLoadFilter.m
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "PreLoadFilter.h"
#import "BaseContainerController.h"
#import "FilterModel.h"
#import "StringUtil.h"
#import "ColorUtil.h"
@interface PreLoadFilter ()
@property(nonatomic,weak)BaseContainerController * container;
@property(nonatomic,strong)FilterModel * filterModel;
@property(nonatomic,strong)NSDictionary * filterConfig;
@end

@implementation PreLoadFilter
+ (instancetype)filterWithContainer:(BaseContainerController *)container{
    PreLoadFilter * filter = [[self alloc]init];
    filter.container = container;
	filter.delegate = container;
    filter.filterModel = [[FilterModel alloc]initWithUrl:container.renderUrl];
    return filter;
}

- (NSDictionary *)filterConfig{
    if (!_filterConfig) {
        _filterConfig = @{};
    }
    return _filterConfig;
    
}


- (void)didFilter{
	if (_delegate && [_delegate respondsToSelector:@selector(willPreLoadFilter:)]) {
		[_delegate willPreLoadFilter:_filterModel];
	}
    if (self.filterModel == nil) {
		if (_delegate && [_delegate respondsToSelector:@selector(preLoadCompleteFilter:)]) {
			[_delegate preLoadCompleteFilter:_filterModel];
		}
        return;
    }
    
    //开始执行过滤逻辑  landscape ,强制横屏
    if ([self.filterModel.xy_orientation isEqualToString:@"landscape"]) {
        [self.container changeDeviceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
    
    //设置导航栏颜色
    if (![StringUtil isEmpty:self.filterModel.xy_nav_bgcolor]) {
        self.container.navigationController.navigationBar.barTintColor = [ColorUtil colorWithHexString:self.filterModel.xy_nav_bgcolor];

    }
    //开始执行过滤逻辑  landscape ,强制横屏
    if ([self.filterModel.xy_nav_show isEqualToString:@"false"]) {
        [self.container.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
	if (_delegate && [_delegate respondsToSelector:@selector(preLoadCompleteFilter:)]) {
		[_delegate preLoadCompleteFilter:_filterModel];
	}
}
@end
