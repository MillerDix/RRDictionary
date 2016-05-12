//
//  AppDelegate.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "AppDelegate.h"
#import "MILTabBarController.h"
#import "MILHomeController.h"
#import "MILDiscoveryController.h"
#import "MILMineController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置window的根控制器为tabBarController
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MILTabBarController *tabController = [[MILTabBarController alloc] init];
    self.window.rootViewController = tabController;
    
    
    //为tabBarController创建子控制器
    //首页控制器
    MILHomeController *homeController = [[MILHomeController alloc] init];
    homeController.title = @"首页";
    UINavigationController *naviHome =[[UINavigationController alloc] initWithRootViewController:homeController];
    
    //发现控制器
    MILDiscoveryController *disController = [[MILDiscoveryController alloc] init];
    disController.title = @"发现";
    UINavigationController *naviDiscovery = [[UINavigationController alloc] initWithRootViewController:disController];
    
    //我的控制器
    MILMineController *mineController = [[MILMineController alloc] initWithStyle:UITableViewStyleGrouped];
    mineController.title = @"我的";
    UINavigationController *naviMine = [[UINavigationController alloc] initWithRootViewController:mineController];
    
    tabController.viewControllers = @[naviHome, naviDiscovery, naviMine];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
