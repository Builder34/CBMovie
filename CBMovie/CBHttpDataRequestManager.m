//
//  CBHttpDataRequestManager.m
//  CBMovie
//
//  Created by builder34 on 15/9/9.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBHttpDataRequestManager.h"

@implementation CBHttpDataRequestManager

static CBHttpDataRequestManager *_instance = nil ;

/**
 *  单例
 **/
+ (instancetype) sharedRequestManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken,^{
        _instance = [[self alloc] init] ;
    }) ;
    return _instance ;
}

+ (JSONModel *) httpRequestWithUrl:(NSString *)requestUrl andParameters:(NSDictionary *)params toReturnObject:(JSONModel *)model{
    NSURL *baseUrl = [NSURL URLWithString:baiduAPI] ;

    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl] ;
    //响应序列
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
    //请求序列
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
    operationManager.requestSerializer.timeoutInterval = 10 ;
    AFHTTPRequestOperation *operation =[operationManager POST:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([responseObject[@"error"] intValue] == 0){
            NSLog(@"请求成功...") ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败： error %@",error) ;
    }] ;
    
    [operation start] ;
    
    return model ;
}


@end
