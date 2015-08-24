//
//  LocationModel.h
//  CBMovie
//
//  Created by builder34 on 15/8/21.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface LocationModel : JSONModel

@property (nonatomic,assign) float lat ;  //纬度
@property (nonatomic,assign) float lng ;  //经度

@end
