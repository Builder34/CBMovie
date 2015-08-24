//
//  AppDelegate.m
//  CBMovie
//
//  Created by builder34 on 15/8/7.
//  Copyright (c) 2015年 builder34. All rights reserved.
//

#import "AppDelegate.h"
#import "CBMainViewController.h"
#import "CBUSAViewController.h"

@interface AppDelegate ()

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

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext ;
@synthesize managedObjectModel = _managedObjectModel ;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator ;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    _window.backgroundColor = [UIColor whiteColor] ;
    [_window makeKeyAndVisible] ;
    
    CBMainViewController *mainViewController = [[CBMainViewController alloc] initWithNibName:nil bundle:nil] ;
    self.window.rootViewController = mainViewController ;
    
    [self initMobClick] ; //初始化友盟统计
    
    return YES;
}

//初始化MobClick友盟统计
- (void) initMobClick{
    //友盟统计
    [MobClick startWithAppkey:@"55d5a3ebe0f55aa4ed000a9a" reportPolicy:BATCH channelId:@"Web"] ;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ;
    [MobClick setAppVersion:version] ;
    //日志加密设置
    [MobClick setEncryptEnabled:YES] ; //默认No
    //后台模式设置
    [MobClick setBackgroundTaskEnabled:YES] ; //默认YES
    
    [MobClick setLogEnabled:YES] ;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {

//    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary] ;
//    NSLog(@"%@",[dict objectForKey:@"CFBundleIdentifier"]) ;
//    NSString *tmpPath = NSTemporaryDirectory() ;
//    NSLog(@"tmpPath %@",tmpPath) ;
//    NSString *homePath = NSHomeDirectory() ;
//    NSLog(@"homePath : %@",homePath) ;
//    NSString *tmpPath2 = [homePath stringByAppendingString:@"/tmp"] ;
//    NSLog(@"tempath2 : %@",tmpPath2) ;
    //NSLog(@"%@",NSStringFromSelector(_cmd)) ;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}
//保存codedata的数据
- (void) saveContext{

    NSError *error = nil ;
    NSManagedObjectContext *managedObjectContext1 = self.managedObjectContext ;
    if(managedObjectContext1 != nil ){
        if([managedObjectContext1 hasChanges] && ![managedObjectContext1 save:&error]){
            NSLog(@"Unresolved error %@ , %@",error,[error userInfo]) ;
            abort() ;
        }
    }
    
}
#pragma mark - Core Data stack  setter方法
- (NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext != nil){
        return _managedObjectContext ;
    }
    NSPersistentStoreCoordinator *coordinator1 = [self persistentStoreCoordinator] ;
    if (coordinator1 != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init] ;
        [_managedObjectContext setPersistentStoreCoordinator:coordinator1] ;
    }
    return _managedObjectContext ;
}

- (NSManagedObjectModel *)managedObjectModel{
    if(_managedObjectModel != nil){
        return _managedObjectModel ;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CBMovie" withExtension:@"momd"] ;
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] ;
    return _managedObjectModel ;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator ;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CBMovie.sqlite"] ;
    NSError *error = nil ;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]] ;
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolvede error %@ , %@",error,[error userInfo]) ;
        abort() ;
    }
    return _persistentStoreCoordinator ;
}

#pragma mark - Application's Documents directory 
- (NSURL *) applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] ;
}

@end
