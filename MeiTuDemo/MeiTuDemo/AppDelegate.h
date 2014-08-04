//
//  AppDelegate.h
//  MeiTuDemo
//
//  Created by yangyong on 14-8-4.
//  Copyright (c) 2014年 zhuofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageAddPreView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ImageAddPreView   *preview;

- (void)showPreView;
- (void)hiddenPreView;

@end
