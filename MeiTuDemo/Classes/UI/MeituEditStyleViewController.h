//
//  MeituEditStyleViewController.h
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeituImageEditView.h"
#import "GLStoryboardSelectView.h"
#import "SharedImageViewController.h"
@interface MeituEditStyleViewController : UIViewController<GLStoryboardSelectViewDelegate>

@property (nonatomic, strong) NSArray           *assets;
@property (nonatomic, strong) UIScrollView      *contentView;
@property (nonatomic, assign) BOOL              *isCallBack;


@property (nonatomic, strong) UIImageView       *bringPosterView;
@property (nonatomic, strong) UIImageView       *freeBgView;

//边框  添加／删除按钮
@property (nonatomic, strong) UIView              *boardAndEditView;
@property (nonatomic, strong) UIButton            *boardbutton;
@property (nonatomic, strong) UIButton            *editbutton;


//底部放的button
@property (nonatomic, strong) UIView            *bottomView;
//
//control button 分镜 自由 拼接的切换按钮
@property (nonatomic, strong) UIButton          *storyboardButton;
@property (nonatomic, strong) UIButton          *posterButton;
@property (nonatomic, strong) UIButton          *spliceButton;
@property (nonatomic, strong) UIButton          *selectControlButton;

//分镜 ， 自由（海报） ， 拼接的样式选择
@property (nonatomic, strong) GLStoryboardSelectView      *storyboardView;
//放如两个selectView
@property (nonatomic, strong) UIScrollView                *bottomControlView;

//目前选中的分镜效果的button
@property (nonatomic, strong) UIButton          *selectedStoryboardBtn;
//目前选择的自由（海报）模式的button
@property (nonatomic, strong) UIButton          *selectedPosterBtn;

@property (nonatomic, strong) UIColor           *selectedBoardColor;

@property (nonatomic, assign) NSInteger         selectStoryBoardStyleIndex;
@property (nonatomic, assign) BOOL              isFirst;

@end
