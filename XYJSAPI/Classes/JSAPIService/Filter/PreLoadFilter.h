//
//  PreLoadFilter.h
//  JSAPI
//
//  Created by Nile on 2018/3/16.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContainerController.h"
@class PreLoadFilter,FilterModel;
@protocol PreLoadFilterProtocol<NSObject>
- (void)preLoadCompleteFilter:(nullable FilterModel *)filter;
- (void)willPreLoadFilter:(nullable FilterModel *)filter;
@end
@interface PreLoadFilter : NSObject
@property (nonatomic, weak) id<PreLoadFilterProtocol> delegate;
+ (instancetype)filterWithContainer:(BaseContainerController *)container;
- (void)didFilter;
@end
