//
//  CBTableViewDataSource.h   自定义UITableViewDataSource
//  CBMovie
//
//  Created by builder34 on 15/9/7.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(UITableViewCell *cell,id item,NSIndexPath *indexPath)  ;

@interface CBTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,assign) BOOL isMoreOver ; //是否 显示更多

/**
 *@Description: 自定义初始化方法
 **/
- (instancetype) initWithData:(NSArray *)data cellIdentifier:(NSString *)identifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock isMore:(BOOL)isMore haveSection:(BOOL)haveSection ;

- (id) itemAtIndexPath:(NSIndexPath *)indexPath ;


@end
