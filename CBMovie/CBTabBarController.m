//
//  CBTabBarController.m
//  CBMovie
//
//  Created by builder34 on 15/9/11.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBTabBarController.h"

@interface CBTabBarController ()

@property (nonatomic,strong) NSMutableArray *imageArray ;
@property (nonatomic,strong) NSMutableArray *labelArray ;
@property (nonatomic,strong) NSMutableArray *buttonArray ;

@end

@implementation CBTabBarController

- (instancetype) initWithTitles:(NSArray *)titles andIcons:(NSArray *)icons {
    self = [super init] ;
    if (self) {
        _selectedIndexNum = -1 ;
        self.titles = titles;
        self.icons = icons ;
        _labelArray = [[NSMutableArray alloc] init] ; //必须初始化 否则后面[_labelArray addObject:] 不起作用，因为_labelArray为nil(不会提示，坑)
        _imageArray = [[NSMutableArray alloc] init] ;
        _buttonArray = [[NSMutableArray alloc] init] ;
        //[self hideRealTabBar] ;
        
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - 这里重写很重要
-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    [super setViewControllers:viewControllers animated:animated] ;
    [self customTabBar] ; //这里调用自定义，自定义的按钮点击事件才不会被原生的tabbar点击事件覆盖
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) customTabBar{

    for (int i = 0; i < _titles.count; i++) {
        UIButton *tabViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(UISCREENWIDTH/_titles.count), 0, UISCREENWIDTH/_titles.count, 49)] ;
        tabViewBtn.backgroundColor = [UIColor whiteColor] ;

        //tab图标
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(((UISCREENWIDTH/_titles.count)-24)/2, 5, 24, 24)] ;
        iconView.contentMode = UIViewContentModeScaleAspectFit ; // 等比宽高
        [iconView setImage:[UIImage imageNamed:_icons[i]]] ;
        [tabViewBtn addSubview:iconView] ;
        [_imageArray addObject:iconView] ;
        //tab文字
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, UISCREENWIDTH/_titles.count, 12)] ;
        titleLabel.text = _titles[i] ;
        titleLabel.font = [UIFont systemFontOfSize:10.0f] ;
        titleLabel.textAlignment = NSTextAlignmentCenter ;
        [tabViewBtn addSubview:titleLabel] ;
        [_labelArray addObject:titleLabel] ;
        //
        tabViewBtn.tag = i ;
        [tabViewBtn addTarget:self action:@selector(selectCustomTabBar:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.tabBar addSubview:tabViewBtn] ;

        [_buttonArray addObject:tabViewBtn] ;
    }
    [self selectCustomTabBar:[_buttonArray objectAtIndex:0]] ;
    
}
//自定义点击事件(更改点击后样式)
- (void) selectCustomTabBar:(UIButton *)sender{
    self.selectedIndex = sender.tag ; //不可缺少
    if (_selectedIndexNum == sender.tag) {
        return ;
    }
    _selectedIndexNum = sender.tag ;
    
    for (int i = 0; i < _titles.count; i++) {
        UILabel *label = [_labelArray objectAtIndex:i] ;
        if (i == _selectedIndexNum) {
            label.textColor = [UIColor redColor] ;
        }else{
            label.textColor = [UIColor grayColor] ;
        }
    }
    for(int i = 0 ; i < _titles.count ; i++){
        UIButton *button = [_buttonArray objectAtIndex:i] ;
        if(i == _selectedIndexNum){
            button.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1] ;
        }else{
            button.backgroundColor = [UIColor whiteColor] ;
        }
    }
}

@end
