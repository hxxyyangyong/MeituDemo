//
//  SharedImageViewController.h
//  ;
//
//  Created by yangyong on 14-4-25.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZYQAssetPickerController.h"
#import "HomeMenuViewController.h"
@interface SharedImageViewController : UIViewController
@property (nonatomic, strong) UIImageView   *sharedImageView;
@property (nonatomic, strong) UIScrollView  *contentView;
@property (nonatomic, strong) UIImage       *image;
@end
