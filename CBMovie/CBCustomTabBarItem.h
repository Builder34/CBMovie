//
//  CBCustomTabBarItem.h
//  CBMovie
//
//  Created by builder34 on 15/8/20.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCustomTabBarItem : UIView

@property (nonatomic,strong) UIImageView *iconView ;  //图标
@property (nonatomic,strong) UILabel *titleLabel ;    //标题


- (instancetype) initWithFrame:(CGRect)frame andIcon:(NSString *)imageName andTitle:(NSString *)titleName andIndex:(int)index ;

@end
