//
//  CBTitleView.h
//  CBMovie
//
//  Created by builder34 on 15/9/10.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTitleView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftButton; //导航左按钮
@property (weak, nonatomic) IBOutlet UIButton *rightButton;  //导航右按钮

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  //导航标题label
@end
