//
//  CBMainViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/19.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBMainViewController.h"

#import "CBHomeViewController.h"
#import "CBNewsViewController.h"
#import "CBUSAViewController.h"
#import "CBTop250ViewController.h"

#import "CBCustomTabBarItem.h"

@interface CBMainViewController (){
    UIImageView *_tabBarBackgroundView ; //自定义tabBar的背景图
    NSArray *_viewControllers ;
    NSArray *_icons ;
    NSArray *_titleNames ;
    
    UIView *_selectedBackView  ;  //tabBarItem选中时的背景
}

@end

@implementation CBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self loadViewContorllers] ;
    [self settingCustomTabBar] ;
}

//装载子视图控制器
- (void) loadViewContorllers{
    
    CBHomeViewController *homeVC = [[CBHomeViewController alloc] initWithNibName:nil bundle:nil] ;
    
    CBUSAViewController *usaVC = [[CBUSAViewController alloc] initWithNibName:nil bundle:nil] ;
    UINavigationController *usaNavigation = [[UINavigationController alloc] initWithRootViewController:usaVC] ;

    
    CBTop250ViewController *topVC = [[CBTop250ViewController alloc] init] ;
    UINavigationController *topNavigation = [[UINavigationController alloc] initWithRootViewController:topVC] ;
    
    CBNewsViewController *newsVC = [[CBNewsViewController alloc] init] ;
    UINavigationController *newsNavigation = [[UINavigationController alloc] initWithRootViewController:newsVC] ;
    
    _viewControllers = @[homeVC,usaNavigation,topNavigation,newsNavigation] ;
    _icons = @[@"home",@"usa",@"top250",@"news"] ;
    _titleNames = @[@"热映",@"usa",@"top250",@"新闻"] ;
    
    [self setViewControllers:_viewControllers animated:YES] ;
    
}
//设置自定义tabBar
- (void) settingCustomTabBar{
    self.tabBar.hidden = YES ; //隐藏系统的tabBar
    
    _tabBarBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UISCREENHEIGHT-49, UISCREENWIDTH, 49)];
    _tabBarBackgroundView.image = [UIImage imageNamed:@"tabbar_background"] ;
    _tabBarBackgroundView.userInteractionEnabled = YES ; //这一步一定要设置，否则不能和用户交互
    
    CGFloat tabBatItemWidth = (_tabBarBackgroundView.frame.size.width)/_viewControllers.count ;
    _selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, tabBatItemWidth, 48)] ;
    _selectedBackView.backgroundColor = [UIColor whiteColor] ;
    
//    CALayer *topBorder = [CALayer layer] ;
//    topBorder.frame = CGRectMake(0, 0, _selectedBackView.frame.size.width, 1.0f) ;
//    topBorder.backgroundColor = [UIColor clearColor].CGColor ;
//    [_selectedBackView.layer addSublayer:topBorder] ;
    
    
    [_tabBarBackgroundView addSubview:_selectedBackView] ;

    
    for (int i = 0; i<_viewControllers.count; i++) {
        
        CBCustomTabBarItem *item = [[CBCustomTabBarItem alloc] initWithFrame:CGRectMake(tabBatItemWidth*i, 0, tabBatItemWidth, 49) andIcon:_icons[i] andTitle:_titleNames[i] andIndex:i] ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] ;
        [item addGestureRecognizer:tap] ;

        [_tabBarBackgroundView addSubview:item] ;
    }
    
    [self.view addSubview:_tabBarBackgroundView] ;
}


//手势操作
- (void)handleTap:(UITapGestureRecognizer *)sender{
    //NSLog(@"item x %f",sender.view.frame.origin.x) ;
    _selectedBackView.frame = CGRectMake(sender.view.frame.origin.x, 1, sender.view.frame.size.width, 48) ;
    self.selectedIndex = sender.view.tag ;  //当前选中tabIndex
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
