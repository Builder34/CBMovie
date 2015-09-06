//
//  LocationzEntity.h
//  CBMovie
//
//  Created by builder34 on 15/8/24.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LocationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;

@end
