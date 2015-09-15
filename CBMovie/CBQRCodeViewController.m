//
//  CBQRCodeViewController.m
//  CBMovie
//
//  Created by builder34 on 15/9/15.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBQRCodeViewController.h"

@interface CBQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@end

@implementation CBQRCodeViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
    
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1/255.0f green:1/255.0f blue:1/255.0f alpha:1] ;
    
    [self setupLayout] ;
}

//设置布局
- (void) setupLayout{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, UISCREENWIDTH, 44)] ;
    titleLabel.text = @"iOS7以上使用AVFoundation框架实现二维码扫描" ;
    titleLabel.textColor = [UIColor grayColor] ;
    titleLabel.font = [UIFont systemFontOfSize:13.0f] ;
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    
    UIImageView *cameraView = [[UIImageView alloc] initWithFrame:CGRectMake((UISCREENWIDTH-230)/2, 100, 230, 230)] ;
    [cameraView setImage:[UIImage imageNamed:@"qr_pick_bg"]] ;
    [self.view addSubview:cameraView] ;
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake((UISCREENWIDTH-210)/2, 110, 210, 2)] ;
    [_lineView setImage:[UIImage imageNamed:@"qr_line"]] ;
    [self.view addSubview:_lineView] ;
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((UISCREENWIDTH-250)/2, 400, 250, 44)] ;
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal] ;
    [cancelBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:cancelBtn] ;
    
    _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(cameraView.frame)+12, UISCREENWIDTH-20, 44)] ;
    _resultLabel.font = [UIFont systemFontOfSize:12.0f] ;
    _resultLabel.textColor = [UIColor whiteColor] ;
    _resultLabel.text = @"等待扫描结果..." ;
    [self.view addSubview:_resultLabel] ;

    upOrDown = NO ;
    num = 0 ;
    //设置Camera
}
- (void) setupCamera{
    //Device
    _avDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] ;
    //Input
    _avInput = [AVCaptureDeviceInput deviceInputWithDevice:_avDevice error:nil] ;
    //Output
    _avOutput = [[AVCaptureMetadataOutput alloc] init] ;
    [_avOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()] ;
    //Session
    _avSession = [[AVCaptureSession alloc] init] ;
    [_avSession setSessionPreset:AVCaptureSessionPresetHigh] ;
    if ([_avSession canAddInput:_avInput]) {
        [_avSession addInput:_avInput] ;
    }
    if([_avSession canAddOutput:_avOutput]){
        [_avSession addOutput:_avOutput] ;
    }
    //条码类型
    if([_avOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]){
        _avOutput.metadataObjectTypes = [NSArray arrayWithObject:AVMetadataObjectTypeQRCode] ;
    }
    _avPreview = [AVCaptureVideoPreviewLayer layerWithSession:_avSession] ;
    _avPreview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    _avPreview.frame = CGRectMake((UISCREENWIDTH-210)/2, 110, 210, 210) ;
    
    [self.view.layer insertSublayer:_avPreview atIndex:0] ;

}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate 实现
- (void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *resultString ;
    if([metadataObjects count] > 0){
        NSLog(@"metadataObjects count %lu",(unsigned long)[metadataObjects count]) ;
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0] ;
        resultString = metadataObject.stringValue ;
        _resultLabel.text = resultString ;
    }
    [_avSession stopRunning] ;
    NSLog(@"resultString %@",resultString) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self setupCamera] ;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanLineAnimation) userInfo:nil repeats:YES] ;
    [_avSession startRunning] ;
}
- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated] ;
    [timer invalidate] ; //销毁定时器
    [_avSession stopRunning] ;
}
//定时器触发 lineView移动
- (void) scanLineAnimation{
    //NO表示向下
    if(upOrDown == NO){
        num++ ;
        _lineView.frame = CGRectMake(_lineView.frame.origin.x, 110+num*2, _lineView.frame.size.width, _lineView.frame.size.height) ;
        if(2*num >= 210){
            upOrDown = YES ; //YES表示向上
        }
    }else{
        num-- ;
        _lineView.frame = CGRectMake(_lineView.frame.origin.x, 110+num*2, _lineView.frame.size.width, _lineView.frame.size.height) ;
        if (num <= 0) {
            upOrDown = NO ;
        }
    }
}

- (void) backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
