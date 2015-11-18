//
//  CBHomeViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/20.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBHomeViewController.h"
#import "AFNetworking.h"
#import "CBHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "MovieOfCityModel.h"
#import "MovieModel.h"
#import "LocationEntity.h"
#import "AppDelegate.h"

#import "CBHotShowingCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "CBHttpDataRequestManager.h"
#import "CBMovieDetailsViewController.h"


@interface CBHomeViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager ;

@property (nonatomic,assign) CLLocationDegrees latitude ;  //纬度
@property (nonatomic,assign) CLLocationDegrees longitude ; //经度

@property (nonatomic,strong) UIView *headerView  ;
@property (nonatomic,strong) UITableView *mainTableView ; //主体表格

@property (nonatomic,strong) MovieOfCityModel *movie ; //电影数据

@property (nonatomic,assign) NSInteger lastContentOffsetY ;

//code data context
@property (strong,nonatomic) NSManagedObjectContext *context ;

@property (assign,nonatomic) CGFloat oldOffsetY ;
@end

@implementation CBHomeViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){

    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.titleLabel.text = @"首页" ;
    //默认设置经纬度
    _latitude = 23.15 ;
    _longitude = 113.23 ;
    
    _lastContentOffsetY = 0 ;
    _oldOffsetY = 0 ;
    //UIView放在init方法初始化 好像不起作用？为何?
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 59)] ;
    _headerView.backgroundColor = [UIColor greenColor] ;
    [self.view addSubview:_headerView] ;
    
    self.homeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64+59, UISCREENWIDTH, UISCREENHEIGHT-64-59-49)] ;
    self.homeScrollView.backgroundColor = [UIColor grayColor] ;
    [self.view addSubview:_homeScrollView] ;
    
    [self setupLocationManager] ;
    [self settingLayout] ;
    [self requestData] ;
    
    //这里需要引入自己项目的委托，就是让全局managedObjectContext起作用
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;
    self.context = appDelegate.managedObjectContext ;
    
}
//请求数据
- (void) requestData{
    NSURL *baseUrl = [NSURL URLWithString:baiduAPI] ;
    
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc]  initWithBaseURL:baseUrl] ;
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer] ;

    operationManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
    operationManager.requestSerializer.timeoutInterval = 10 ;
    AFHTTPRequestOperation *operation = [operationManager GET:@"movie" parameters:@{@"qt":@"hot_movie",@"location":[NSString stringWithFormat:@"%f,%f",_longitude,_latitude],@"ak":@"Xvm0dTWbPHP4Lez6Ffk1BjVO",@"output":@"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"error"] intValue] == 0) {
            //NSLog(@"请求成功！") ;
            NSError *err = nil ;
            [self hideLoadingView] ;
            _movie = [[MovieOfCityModel alloc] initWithDictionary:responseObject[@"result"] error:&err] ;
            LocationEntity *locationEntity = [NSEntityDescription insertNewObjectForEntityForName:@"LocationEntity" inManagedObjectContext:_context] ;
            [_mainTableView reloadData] ; //更新表格数据
            locationEntity.lat = [NSNumber numberWithFloat:_movie.location.lat] ;
            locationEntity.lng = [NSNumber numberWithFloat:_movie.location.lng] ;
            NSError *contextError = nil ;
            if (![_context save:&contextError]) {
                NSLog(@"%@",[contextError localizedDescription]) ;
                
            }
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init] ;
//            NSEntityDescription *entity = [NSEntityDescription entityForName:@"LocationEntity" inManagedObjectContext:_context] ;
//            [fetchRequest setEntity:entity] ;
//            
//            NSArray *fetchObject = [_context executeFetchRequest:fetchRequest error:&contextError] ;
//            for (NSManagedObject *info in fetchObject) {
//                NSLog(@"entity lat: %@",[info valueForKey:@"lat"]) ;
//                NSLog(@"entity lng: %@",[info valueForKey:@"lng"]) ;
//            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error : %@",error.description) ;
        self.hubLoadingView.labelText = @"请求出错";
        [self hideLoadingViewAfterDelay:3.0f];
    }] ;

    //[operation start] ;
    

}
//定位
- (void) setupLocationManager{
    self.locationManager = [[CLLocationManager alloc] init] ;
    _locationManager.delegate = self ;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    _locationManager.distanceFilter = 10 ;
    
    [_locationManager requestAlwaysAuthorization] ; //iOS8 需要添加此句
    
    //[_locationManager startUpdatingLocation] ;
    NSLog(@"开始定位..") ;
}

#pragma mark - CLLocationManagerDelegate 
//获取位置数据
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations lastObject] ;
    _latitude = currentLocation.coordinate.latitude ;
    _longitude = currentLocation.coordinate.longitude ;
    
    [self requestData] ;
    [_locationManager stopUpdatingLocation] ;
}
//
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.hubLoadingView.labelText = @"无法定位..."  ;
    [self hideLoadingViewAfterDelay:3.0f] ;
    if([error code] == kCLErrorDenied){
        NSLog(@"访问被拒绝") ;
    }
    if([error code] == kCLErrorLocationUnknown){
        NSLog(@"无法获取位置信息") ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    
    [_locationManager stopUpdatingLocation] ;
    
    [MobClick endLogPageView:@"PageOne"] ;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    //页面统计
    [MobClick beginLogPageView:@"PageOne"] ;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
}
//设置布局
- (void) settingLayout{
    [self.titleView.leftButton setTitle:@"城市" forState:UIControlStateNormal] ;
    //设置titleView的右按钮
    [self.titleView.rightButton setTitle:@"定位" forState:UIControlStateNormal] ;
    [self.titleView.rightButton addTarget:self action:@selector(getLocation) forControlEvents:UIControlEventTouchUpInside] ;
    //设置主体表格
    _mainTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH,self.homeScrollView.frame.size.height) style:UITableViewStylePlain] ;
    //注册加载自定义cell的xib文件
    UINib *nib = [UINib nibWithNibName:@"CBHotShowingCell" bundle:nil] ;
    [_mainTableView registerNib:nib forCellReuseIdentifier:@"hotShowingCell"] ;
    
    _mainTableView.dataSource = self ;
    _mainTableView.delegate = self ;
    [self setupRefresh] ;
    _mainTableView.tableHeaderView = nil ;
    [self.homeScrollView addSubview:_mainTableView] ;
}
//集成下拉刷新
- (void) setupRefresh{
    //1.添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init] ;
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged] ;
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"下拉刷新..." attributes:nil] ;
    refreshControl.attributedTitle = attributeStr ;
    [self.mainTableView addSubview:refreshControl] ;
    
    //2.马上进入刷新状态，并不会触发UIControllerEventChanged事件
    [refreshControl beginRefreshing] ;
    //3.加载数据
    [self refreshStateChange:refreshControl] ;
}
//刷新触发事件
- (void) refreshStateChange:(UIRefreshControl *)control{
    [self showLoadingView] ;
    [self requestData] ;
    //结束刷新
    [control endRefreshing] ;
}
//开始定位
- (void) getLocation {
    [_locationManager startUpdatingLocation] ;
    [self encodeCityByLatitude:_latitude andLongitude:_longitude] ;
}
//解析经纬度转换成城市
- (void) encodeCityByLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude{
    
    //反地理编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude] ;
    CLGeocoder *gecoder = [[CLGeocoder alloc] init] ;
    __block  CLPlacemark *placemark =nil ;
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        placemark = [placemarks firstObject] ;
        [self.titleView.leftButton setTitle:[NSString stringWithFormat:@"%@",placemark.addressDictionary[@"City"]] forState:UIControlStateNormal] ;
        NSLog(@"定位到的城市为：%@",placemark.addressDictionary[@"City"]) ;
    }] ;
    
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;

    CBMovieDetailsViewController *movieDetailVC = [[CBMovieDetailsViewController alloc] init] ;
    movieDetailVC.movieModel = _movie.movie[indexPath.row] ;
    [self.navigationController pushViewController:movieDetailVC animated:YES] ;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1 ;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79 ;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"行数：%lu",(unsigned long)[_movie.movie count]) ;
    return [_movie.movie count] ;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CBHotShowingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotShowingCell"] ;
    MovieModel *movieModel = self.movie.movie[indexPath.row] ;
    cell.movieName.text = [NSString stringWithFormat:@"名称：%@",movieModel.movie_name] ;
    cell.movieType.text = [NSString stringWithFormat:@"%@  %@",movieModel.movie_type,movieModel.is_imax?@"IMAX":@""] ;
    
    //SDWebImage库
    [cell.movieImage sd_setImageWithURL:[NSURL URLWithString:movieModel.movie_picture] placeholderImage:[UIImage imageNamed:@"movie-default"]] ;

    return cell ;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    //滑动到顶部或底部弹回不做处理
    if(scrollView.contentOffset.y>5 && scrollView.contentOffset.y < scrollView.contentSize.height-UISCREENHEIGHT){
        //向上滑动，隐藏navigationView和tabBar
        if(scrollView.contentOffset.y > _oldOffsetY){
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect titleFrame = self.titleView.frame ;
                if (titleFrame.origin.y == 20) {
                     self.titleView.frame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y-64, UISCREENWIDTH, 44) ;
                }
                self.tabBarController.tabBar.hidden = YES ;
                CGRect scrollFrame = self.homeScrollView.frame ;
                if(scrollFrame.origin.y == 123){
                    self.headerView.frame = CGRectMake(0, 20, UISCREENWIDTH, 59) ;
                    self.homeScrollView.frame = CGRectMake(scrollFrame.origin.x, scrollFrame.origin.y-44, scrollFrame.size.width, scrollFrame.size.height+44+49) ;
                    self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, self.mainTableView.frame.size.width, self.homeScrollView.frame.size.height) ;
                }

            } completion:^(BOOL finished) {
                
            }] ;

        }
        //向下滑动，显示navigationView和tabBar
        if(scrollView.contentOffset.y < _oldOffsetY){
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                 CGRect titleFrame = self.titleView.frame ;
                if (titleFrame.origin.y == -44) {
                    self.titleView.frame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y+64, UISCREENWIDTH, 44) ;
                }
                self.tabBarController.tabBar.hidden = NO ;
                CGRect scrollFrame = self.homeScrollView.frame ;
                if(scrollFrame.origin.y == 79){
                    self.headerView.frame = CGRectMake(0, 64, UISCREENWIDTH, 59) ;
                    self.homeScrollView.frame = CGRectMake(scrollFrame.origin.x, scrollFrame.origin.y+44, scrollFrame.size.width, scrollFrame.size.height-44-49) ;
                    self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, self.mainTableView.frame.size.width, self.homeScrollView.frame.size.height) ;
                }
            } completion:^(BOOL finished) {

            }] ;
        }
    }
    _oldOffsetY = scrollView.contentOffset.y ;
}

@end
