//
//  CBUSAViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/19.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBUSAViewController.h"
#import "FDSlideBar.h"

@interface CBUSAViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) FDSlideBar *slideMenu ;
//@property (nonatomic,strong) UITableView *sliderTableView ; //用作为侧滑滚动视图
@property (nonatomic,strong) UIScrollView *sliderBodyView ;

@property (nonatomic,assign) int currentPage ; //当前页
@end

@implementation CBUSAViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
        self.titleView.titleLabel.text = @"侧滑菜单" ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSlideMenu] ;
    [self setupSlideBodyView] ;
}

//设置滑动菜单
- (void) setupSlideMenu{
    FDSlideBar *slideMenu = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), UISCREENWIDTH, 44)] ;
    slideMenu.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0] ;
    slideMenu.itemsTitle = @[@"首页",@"自己玩",@"周边游",@"一起玩",@"亲子"] ;
    slideMenu.itemColor = [UIColor whiteColor] ;
    slideMenu.itemSelectedColor = [UIColor orangeColor] ;
    slideMenu.sliderColor = [UIColor orangeColor] ; //底部滑动条颜色
    
    //slideMenu选择回调
    [slideMenu slideBarItemSelectedCallback:^(NSUInteger idx) {
        _currentPage = (int)idx ;
        [_sliderBodyView scrollRectToVisible:CGRectMake(UISCREENWIDTH*_currentPage, _sliderBodyView.frame.origin.y, _sliderBodyView.frame.size.width, _sliderBodyView.frame.size.width) animated:NO] ;
        
    }] ;
    self.slideMenu = slideMenu ;
    [self.view addSubview:slideMenu] ;
}
//设置滑动的主体View
- (void) setupSlideBodyView{
    _currentPage = 0 ;  //初始化时当前页设为0
    
    _sliderBodyView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_slideMenu.frame), UISCREENWIDTH, UISCREENHEIGHT-CGRectGetMaxY(_slideMenu.frame)-49)] ;
    
    _sliderBodyView.contentSize = CGSizeMake(UISCREENWIDTH*_slideMenu.itemsTitle.count, _sliderBodyView.frame.size.height) ;

    for (int i = 0 ; i<[_slideMenu.itemsTitle count]; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(UISCREENWIDTH*i, 0, UISCREENWIDTH, _sliderBodyView.frame.size.height)] ;
        view.backgroundColor = [UIColor colorWithRed:40*i/255.0f green:20*i/255.0f blue:50*i/255.0f alpha:1] ;
        [self.sliderBodyView addSubview:view] ;
    }
    
    _sliderBodyView.pagingEnabled = YES ;  //整页滑动
    _sliderBodyView.showsHorizontalScrollIndicator = NO ;  //不显示水平滑动指示
    _sliderBodyView.delegate = self ;
    [self.view addSubview:_sliderBodyView] ;
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



#pragma mark - UIScrollViewDelegate 实现
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x>_currentPage*UISCREENWIDTH ) {
        if(_currentPage < [_slideMenu.itemsTitle count]-1){
            _currentPage++ ;
        }
    }else if(scrollView.contentOffset.x < _currentPage*UISCREENWIDTH){
        if(_currentPage > 0){
            _currentPage-- ;
        }
    }

    [_slideMenu selectSlideBarItemAtIndex:_currentPage] ;
}


@end
