//
//  RootController.h
//  CBMovie
//
//  Created by builder34 on 15/9/11.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBTitleView.h"
#import "MBProgressHUD.h"

@interface RootViewController : UIViewController

@property (nonatomic,strong) CBTitleView *titleView ; //头部导航视图

@property (nonatomic,strong) MBProgressHUD *hubLoadingView ;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ;

- (void) showLoadingView ;
- (void) hideLoadingView ;
- (void) hideLoadingViewAfterDelay:(CGFloat)delay ;
@end
