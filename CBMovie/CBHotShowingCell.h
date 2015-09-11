//
//  CBHotShowingCell.h   热映 tableViewCell
//  CBMovie
//
//  Created by builder34 on 15/8/25.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBHotShowingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieType;

@end
