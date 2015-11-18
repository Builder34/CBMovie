//
//  CBMovieDetailsViewController.m
//  CBMovie
//
//  Created by builder34 on 15/9/18.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBMovieDetailsViewController.h"

@interface CBMovieDetailsViewController ()

@end

@implementation CBMovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]] ;
    NSLog(@"电影名字：  %@",self.movieModel.movie_name) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
