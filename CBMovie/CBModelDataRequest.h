//
//  CBModelDataRequest.h   model数据网络请求类
//  CBMovie
//
//  Created by builder34 on 15/9/9.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "AFNetworking.h"

typedef void(^requestSuccess)(NSMutableArray *data,int totalSize) ;

@interface CBModelDataRequest : JSONModel

@property (nonatomic,copy) NSString *pageSize ; //每页大小
@property (nonatomic,copy) NSString *page ;     //页码

@property (nonatomic,assign) BOOL isLoading ;
@property (nonatomic,assign) BOOL isLoadMore ;
@property (nonatomic,assign) BOOL isFirstLoad ;

@property (nonatomic,copy) requestSuccess successBlock ;  //请求成功block

- (AFHTTPRequestOperation *) httpWithController:(UIViewController *)controller andData:(NSMutableArray *)data andBlock:(requestSuccess)block andUrl:(NSString *)url ;

@end
