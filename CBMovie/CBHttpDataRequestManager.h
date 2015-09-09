//
//  CBHttpDataRequestManager.h  网络数据请求类
//  CBMovie
//
//  Created by builder34 on 15/9/9.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONModel.h"

@interface CBHttpDataRequestManager : NSObject

+ (instancetype) sharedRequestManager ;

+ (JSONModel *) httpRequestWithUrl:(NSString *)requestUrl andParameters:(NSDictionary *)params toReturnObject:(JSONModel *)model ;

@end
