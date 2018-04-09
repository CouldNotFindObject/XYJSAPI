//
//  DispatcherModel.h
//  JSAPI
//
//  Created by Nile on 2018/3/19.
//  Copyright © 2018年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseComponent.h"

extern NSString *const SuccessMsg;
extern NSString *const CancelMsg;
extern NSString *const FailreMsg;

@interface DispatcherModel : NSObject
@property(nonatomic,copy)GGJBResponseSuccessCallback successCallback;
@property(nonatomic,copy)GGJBResponseFailreCallback failreCallback;
@property(nonatomic,copy)GGJBResponseCancelCallback cancelCallback;
@property(nonatomic,strong)id data;

- (instancetype)initWithData:(id)data
          andSuccessCallback:(GGJBResponseSuccessCallback)successCallback
           andFailreCallback:(GGJBResponseFailreCallback)failreCallback
           andCancelCallback:(GGJBResponseCancelCallback)cancelCallback;
- (void)callSuccess:(id)msg;
- (void)callFailre:(id)msg;
- (void)callCancel:(id)msg;

@end
