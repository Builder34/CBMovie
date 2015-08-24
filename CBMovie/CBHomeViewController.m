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
#import "MBProgressHUD.h"
#import "MovieOfCityModel.h"


@interface CBHomeViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager ;

@property (nonatomic,assign) CGFloat latitude ;  //纬度
@property (nonatomic,assign) CGFloat longitude ; //经度

@property (nonatomic,strong) UITableView *mainTableView ; //主体表格

@property (nonatomic,strong) MBProgressHUD *mbProgress ;

@end

@implementation CBHomeViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
        self.title = @"热映" ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self settingLayout] ;
    [self settingProgerss] ;
    
    [self getLocation] ;
    
    //[self requestData] ;
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
            NSLog(@"请求成功！") ;
            NSError *err = nil ;
           // MovieOfCityModel *movie = [[MovieOfCityModel alloc] initWithString:responseObject[@"result"] error:&err] ;
            MovieOfCityModel *movie = [[MovieOfCityModel alloc] initWithDictionary:responseObject[@"result"] error:&err] ;

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"error : %@",error.description) ;
    }] ;

    [operation start] ;
    

}
//定位
- (void) getLocation{
    self.locationManager = [[CLLocationManager alloc] init] ;
    _locationManager.delegate = self ;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    _locationManager.distanceFilter = 10 ;
    
    [_locationManager requestAlwaysAuthorization] ; //iOS8 需要添加此句
    
    [_locationManager startUpdatingLocation] ;
    //NSLog(@"开始定位..") ;
}

#pragma mark - CLLocationManagerDelegate 
//获取位置数据
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations lastObject] ;
    NSLog(@"经度:%f,纬度: %f,高度:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,currentLocation.altitude) ;
    _latitude = currentLocation.coordinate.latitude ;
    _longitude = currentLocation.coordinate.longitude ;
    
    [self requestData] ;
    
}
//
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
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

//设置布局
- (void) settingLayout{
    _mainTableView =[[UITableView alloc] initWithFrame:tabBarMainFrame style:UITableViewStylePlain] ;
    _mainTableView.dataSource = self ;
    _mainTableView.delegate = self ;
    
    _mainTableView.tableHeaderView = nil ;
    
    NSLog(@"_maunTableView y : %f  height : %f",_mainTableView.frame.origin.y,_mainTableView.frame.size.height) ;
    [self.view addSubview:_mainTableView] ;
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        NSLog(@"第3行cell被点击...") ;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1 ;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12 ;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify"] ;
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellIdentify"] ;
        if (indexPath.row == 2) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((UISCREENWIDTH-200)/2, 0, 200, 44)] ;
            title.text = @"MBProgressHUD" ;
            title.textAlignment = NSTextAlignmentCenter ;
            title.textColor = [UIColor grayColor] ;
            [cell.contentView addSubview:title] ;
            
        }
    }
    return cell ;
}
//设置加载提示
- (void) settingProgerss{
    _mbProgress = [[MBProgressHUD alloc] initWithView:_mainTableView] ;
    [self.view addSubview:_mbProgress] ;
    _mbProgress.mode = MBProgressHUDModeDeterminate ;
    _mbProgress.delegate = self ;
    _mbProgress.labelText = @"拼命加载中..." ;
    
    [_mbProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES] ;
}
- (void) myProgressTask{
    float progress = 0.0f ;
    while (progress < 1.0f) {
        progress += 0.01f ;
        _mbProgress.progress = progress ;
        usleep(50000) ;
    }
}
@end
