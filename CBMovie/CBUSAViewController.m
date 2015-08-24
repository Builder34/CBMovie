//
//  CBUSAViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/19.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBUSAViewController.h"

@interface CBUSAViewController ()

@end

@implementation CBUSAViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
        self.title = @"美国榜" ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [MobClick beginLogPageView:@"usaVC"] ;
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    [MobClick endLogPageView:@"usaVC"] ;
}

#pragma mark -memory 警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
