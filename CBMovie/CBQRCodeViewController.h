//
//  CBQRCodeViewController.h   iOS7以上使用AVFoundation框架扫描二维码
//  CBMovie
//
//  Created by builder34 on 15/9/15.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CBQRCodeViewController : UIViewController{
    
    int num ;
    BOOL upOrDown ;
    NSTimer *timer ;
    
}

@property (nonatomic,strong) AVCaptureDevice *avDevice ;
@property (nonatomic,strong) AVCaptureDeviceInput *avInput ;
@property (nonatomic,strong) AVCaptureMetadataOutput *avOutput ;
@property (nonatomic,strong) AVCaptureSession *avSession ;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *avPreview ;
@property (nonatomic,retain) UIImageView *lineView ;

@property (nonatomic,strong) UILabel *resultLabel ;

@end
