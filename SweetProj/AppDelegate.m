//
//  AppDelegate.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/21.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "PersonalVC.h"
#import "TopicVC.h"
#import <QMapKit/QMapKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //如果本身默认使用storyboard,就不需要window的初始化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabController = [[UITabBarController alloc] init];
    
    MainVC *mainVC = [[MainVC alloc] init];
    mainVC.title = @"主页";
    mainVC.tabBarItem.image = [[UIImage imageNamed:@"main"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"mainSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //mainVC.tabBarItem.imageInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    TopicVC *topicVC = [[TopicVC alloc] init];
    topicVC.title = @"圈子";
    topicVC.tabBarItem.image = [[UIImage imageNamed:@"topic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    topicVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"topicSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    PersonalVC *personalVC = [[PersonalVC alloc] init];
    personalVC.title = @"我的";
    personalVC.tabBarItem.image = [[UIImage imageNamed:@"personal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personalVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"personalSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //分别管理三个不同的栈，其实就是三个不同的Navigation
    UINavigationController *naviFirst = [[UINavigationController alloc] initWithRootViewController:mainVC];
    UINavigationController *naviSecond = [[UINavigationController alloc] initWithRootViewController:topicVC];
    UINavigationController *naviThird = [[UINavigationController alloc] initWithRootViewController:personalVC];
    
    self.tabController.viewControllers = @[naviFirst,naviSecond,naviThird];
    
    // 默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = RGB(102,174,55);
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    self.window.rootViewController = self.tabController;
    //设置为主window并显示，否则启动后是黑屏
    [self.window makeKeyAndVisible];
    
    
    // 腾讯地图API
    [QMapServices sharedServices].apiKey = @"DUSBZ-LL63F-FOIJI-J2GW4-TWNFT-FEFBB";
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
