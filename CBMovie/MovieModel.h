//
//  MovieModel.h
//  CBMovie
//
//  Created by builder34 on 15/8/21.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface MovieModel : JSONModel

@property (nonatomic,assign) int is_imax ;  //是否imax
@property (nonatomic,assign) int is_new ;   //是否首次上映
@property (nonatomic,strong) NSString *movie_big_picture ; // 影片大图片地址
@property (nonatomic,strong) NSString *movie_director ;  //影片导演
@property (nonatomic,strong) NSString *movie_id ;   //影片id
@property (nonatomic,strong) NSString *movie_length ; // 影片时长
@property (nonatomic,strong) NSString *movie_message ;  // 影片概要信息
@property (nonatomic,strong) NSString *movie_name ;  //影片名称
@property (nonatomic,strong) NSString *movie_nation ; //影片所属国家
@property (nonatomic,strong) NSString *movie_picture ; // 影片图片地址
@property (nonatomic,strong) NSString *movie_release_date ; //影片上映时间
@property (nonatomic,strong) NSString *movie_score ;  //影片评分
@property (nonatomic,strong) NSString *movie_starring ;  //影片演员
@property (nonatomic,strong) NSString *movie_tags ;   //影片所属类型
@property (nonatomic,strong) NSString *movie_type ;  //影片类型，如3D
@property (nonatomic,strong) NSString *movies_wd ;   //影片关键字

@end
