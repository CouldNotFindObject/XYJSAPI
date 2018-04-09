//
//  FilterModel.h
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

/**
 设置容器的导航栏背景颜色
 */
@property(nonatomic,copy)NSString * xy_nav_bgcolor;

/**
 设置容器横竖屏
 */
@property(nonatomic,copy)NSString * xy_orientation;
/**
 设置是否显示导航栏
 */
@property(nonatomic,copy)NSString * xy_nav_show;


/**
 根据渲染的URL路径生成对象

 @param url URL路径字符串
 @return 该模型对象
 */
- (instancetype)initWithUrl:(NSString *)url;
@end
