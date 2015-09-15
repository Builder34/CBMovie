//
//  RootController.m
//  CBMovie
//
//  Created by builder34 on 15/9/11.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "RootController.h"

@interface RootController ()

@end

@implementation RootController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
        _titleView = [[[NSBundle mainBundle] loadNibNamed:@"CBTitleView" owner:self options:nil] lastObject];
        _titleView.frame = CGRectMake(0, STATUSHEIGHT, UISCREENWIDTH, 44) ;
        [_titleView.leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside] ;
        
        [self.view addSubview:_titleView] ;
    }
    return self ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) backAction:(id)sender{
    
    if(!self.navigationController || [[self.navigationController viewControllers] objectAtIndex:0]==self ){
        [self dismissViewControllerAnimated:YES completion:nil] ;
    }else if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    
}
@end
