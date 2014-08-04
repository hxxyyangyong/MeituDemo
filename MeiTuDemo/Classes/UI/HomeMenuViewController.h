//
//  HomeMenuViewController.h
//  MeiTuDemo
//
//  Created by yangyong on 14-8-4.
//  Copyright (c) 2014年 zhuofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"
#import "MeituEditStyleViewController.h"

@interface HomeMenuViewController : UIViewController<UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate,ImageAddPreViewDelegate>

@property (nonatomic, strong) UIButton      *meituMenuButton;
@property (nonatomic, strong) ZYQAssetPickerController *picker;

@end
