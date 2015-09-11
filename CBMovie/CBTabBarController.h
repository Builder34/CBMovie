//
//  CBTabBarController.h
//  CBMovie
//
//  Created by builder34 on 15/9/11.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTabBarController : UITabBarController

@property (nonatomic,strong) NSArray *titles ;
@property (nonatomic,strong) NSArray *icons ;

@property (nonatomic,assign) NSUInteger selectedIndexNum ; //当前选择的tabBar索引

- (instancetype) initWithTitles:(NSArray *)titles andIcons:(NSArray *)icons ;

@end
