//
//  AppDelegate.m
//  MeiTuDemo
//
//  Created by yangyong on 14-8-4.
//  Copyright (c) 2014年 zhuofeng. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeMenuViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
   HomeMenuViewController *homeVC =  [[HomeMenuViewController alloc] init];
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showPreView
{
    if (_preview == nil) {
        _preview = [[ImageAddPreView alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height - 135, self.window.frame.size.width, 135)];
        [_window addSubview:_preview];
    }
    [_preview setAlpha:0];
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [_preview setAlpha:1];
                     } completion:^(BOOL finished) {
                         
                     }];
    [_preview setHidden:NO];
}


- (void)hiddenPreView
{
    [_preview setHidden:YES];
    [_preview setAlpha:0];
    //    [UIView animateWithDuration:0.1
    //                          delay:0
    //                        options:UIViewAnimationOptionCurveEaseInOut
    //                     animations:^{
    //                         [_preview setAlpha:0];
    //                     } completion:^(BOOL finished) {
    //
    //                     }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
