//
//  MovieOfCity.h
//  CBMovie
//
//  Created by builder34 on 15/8/21.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

#import "LocationModel.h"
#import "MovieModel.h"

@protocol MovieModel
@end


@interface MovieOfCityModel : JSONModel

@property (nonatomic,strong) NSString *cityid ;  //城市id
@property (nonatomic,strong) NSString *cityname ;  //城市名称
@property (nonatomic,strong) LocationModel *location ;  //经纬度

@property (nonatomic,strong) NSArray<MovieModel> *movie ;  //电影数组集合

@end
