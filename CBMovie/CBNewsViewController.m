//
//  CBNewsViewController.m
//  CBMovie
//
//  Created by builder34 on 15/8/19.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBNewsViewController.h"


@interface CBNewsViewController ()

@property (nonatomic,strong) ZBarReaderViewController *QRCodeReader ;

@end

@implementation CBNewsViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if(self){
        self.title = @"新闻" ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, UISCREENHEIGHT)] ;
    [button addTarget:self action:@selector(clickScan:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button] ;
    
    
}
//点击扫描按钮事件
- (void)clickScan:(id)sender{
    
    self.QRCodeReader = [[ZBarReaderViewController alloc] init] ;
    self.QRCodeReader.readerDelegate = self ;
    ZBarImageScanner *scanner = self.QRCodeReader.scanner ;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0] ;
    [self presentViewController:_QRCodeReader animated:YES completion:nil] ;
    
}
#pragma mark - ZBarReaderDelegate 实现
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    id<NSFastEnumeration> result = [info objectForKey:ZBarReaderControllerResults] ;
    ZBarSymbol *symbol = nil ;
    for (symbol in result) {
        [self.QRCodeReader dismissViewControllerAnimated:YES completion:nil] ;
        break ;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
