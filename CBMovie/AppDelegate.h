//
//  AppDelegate.h
//  CBMovie
//
//  Created by builder34 on 15/8/7.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  code data
 **/
@property (readonly,strong,nonatomic) NSManagedObjectContext *managedObjectContext ;  //管理数据内容
@property (readonly,strong,nonatomic) NSManagedObjectModel *managedObjectModel ;  //管理数据模型
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator ; //持久性数据协调器

//保存code data数据的方法
- (void) saveContext  ;
//
- (NSURL *) applicationDocumentsDirectory ;

/**
 *
 **/

@end

