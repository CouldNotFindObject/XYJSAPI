//
//  PreLoadFilter.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContainerController.h"
@interface PreLoadFilter : NSObject

+ (instancetype)filterWithContainer:(BaseContainerController *)container;
- (void)didFilter;
@end
