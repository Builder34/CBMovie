//
//  CBTitleView.m
//  CBMovie
//
//  Created by builder34 on 15/9/10.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "CBTitleView.h"

@implementation CBTitleView

- (void) awakeFromNib{
    CALayer *bottomBorder = [CALayer layer] ;
    bottomBorder.frame = CGRectMake(0, 43, UISCREENWIDTH, 0.8);
    bottomBorder.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1].CGColor ;
    [self.layer addSublayer:bottomBorder] ;
}

@end
