//
//  ViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/7.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//在旋转用户界面之前、之间、之后，UIKit会发送一些信息到viewController，可以截获这些消息，从而对UI做出改变
//- (void) viewWillLayoutSubviews{
//    
//    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
//        CGRect rect = self.topLeftVIew.frame ;
//        rect.size.width = 254 ;
//        rect.size.height = 130 ;
//        self.topLeftVIew.frame = rect ;
//        
//        rect = self.topRightView.frame ;
//        rect.origin.x = 294 ;
//        rect.size.width = 254;
//        rect.size.height = 130 ;
//        self.topRightView.frame =rect ;
//        
//        rect = self.bottomView.frame ;
//        rect.origin.y = 170 ;
//        rect.size.width = 528 ;
//        rect.size.height = 130 ;
//        self.bottomView.frame = rect ;
//        
//    }else{
//        CGRect rect = self.topLeftVIew.frame ;
//        rect.size.width = 130 ;
//        rect.size.height = 254 ;
//        self.topLeftVIew.frame = rect ;
//        
//        rect = self.topRightView.frame ;
//        rect.origin.x = 170 ;
//        rect.size.width = 130;
//        rect.size.height = 254 ;
//        self.topRightView.frame =rect ;
//        
//        rect = self.bottomView.frame ;
//        rect.origin.y = 295 ;
//        rect.size.width = 280 ;
//        rect.size.height = 254 ;
//        self.bottomView.frame = rect ;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
