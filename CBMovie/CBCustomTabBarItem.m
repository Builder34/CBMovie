//
//  CBCustomTabBarItem.m
//  CBMovie
//
//  Created by builder34 on 15/8/20.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBCustomTabBarItem.h"

@implementation CBCustomTabBarItem

- (instancetype) initWithFrame:(CGRect)frame andIcon:(NSString *)imageName andTitle:(NSString *)titleName andIndex:(int)index{
    
    self = [super initWithFrame:frame] ;
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, frame.size.width-20, frame.size.height*0.6-2)] ;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit ; //图片等比缩放
        self.iconView.image = [UIImage imageNamed:imageName] ;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height*0.6, frame.size.width, frame.size.height*0.4)] ;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f] ;
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.text = titleName ;
        self.titleLabel.textColor = [UIColor grayColor] ;
        
        self.tag = index ;
        self.backgroundColor = [UIColor clearColor] ;
        
        [self addSubview:_iconView] ;
        [self addSubview:_titleLabel] ;
        
    }
    
    return self ;
    
}


@end
