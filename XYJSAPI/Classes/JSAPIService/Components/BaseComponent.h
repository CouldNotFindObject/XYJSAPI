//
//  BaseComponent.h
//  JSAPI
//
//  Created by Nile on 2018/3/15.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import "BaseContainerController.h"
typedef void (^GGJBResponseSuccessCallback)(id responseData);
typedef void (^GGJBResponseFailreCallback)(id responseData);
typedef void (^GGJBResponseCancelCallback)(id responseData);
@interface BaseComponent : NSObject
@property(nonatomic,weak)BaseContainerController * container;
@end
