//
//  GLStoryboardSelectView.h
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLStoryboardSelectViewDelegate;

@interface GLStoryboardSelectView : UIView

@property (nonatomic, strong) UIScrollView  *storyboardView;
@property (nonatomic, assign) id<GLStoryboardSelectViewDelegate> delegateSelect;
@property (nonatomic, assign) NSInteger      picCount;
@property (nonatomic, assign) NSInteger      selectStyleIndex;

- (id)initWithFrame:(CGRect)frame picCount:(NSInteger)picCount;

@end

@protocol GLStoryboardSelectViewDelegate <NSObject>

- (void)didSelectedStoryboardPicCount:(NSInteger)picCount styleIndex:(NSInteger)styleIndex;

@end
