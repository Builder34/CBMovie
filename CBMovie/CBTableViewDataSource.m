//
//  CBTableViewDataSource.m  
//  CBMovie
//
//  Created by builder34 on 15/9/7.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBTableViewDataSource.h"

@interface CBTableViewDataSource()

@property (nonatomic,strong) NSArray *data ;
@property (nonatomic,copy) NSString *cellIdentifier ;
@property (nonatomic,copy) TableViewCellConfigureBlock configureCellBlock ;
@property (nonatomic,assign) BOOL isMore ;
@property (nonatomic,assign) BOOL hasSection ;

@end

@implementation CBTableViewDataSource

- (instancetype) initWithData:(NSArray *)data cellIdentifier:(NSString *)identifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock isMore:(BOOL)isMore haveSection:(BOOL)haveSection{
    self = [super init] ;
    if(self){
        self.data = data ;
        self.cellIdentifier = identifier ;
        self.configureCellBlock = configureCellBlock ;
        self.isMore = isMore ;
        self.hasSection = haveSection ;
    }
    return self ;
}

//取每行cell对应数据的值
- (id) itemAtIndexPath:(NSIndexPath *)indexPath{
    return (_hasSection) ? _data[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row] : _data[(NSUInteger)indexPath.row] ;
}

#pragma mark - UITableViewDataSource 实现
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return (self.hasSection)?self.data.count:1 ;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.hasSection)?[self.data[section] count]:(self.isMore)?self.data.count+1:self.data.count ;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isMore && self.data.count == indexPath.row){
        //MoreCell
        static NSString *moreCellIdentify = @"moreCellIdentify" ;
        UITableViewCell *moreCell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentify] ;
        if(moreCell == nil){
            moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentify] ;
            //
        }
        return moreCell ;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier] ;
    //取每行cell对应的数据
    id item = [self itemAtIndexPath:indexPath] ;
    
    self.configureCellBlock(cell,item,indexPath) ;
    
    return cell ;
}


@end
