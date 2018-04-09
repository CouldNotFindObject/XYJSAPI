//
//  ComponentModel.h
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComponentModel : NSObject

@property(nonatomic,copy)NSString * jsMethod;
@property(nonatomic,copy)NSString * componentServiceClassName;
@property(nonatomic,copy)NSString * componentServiceMethodName;
@end
