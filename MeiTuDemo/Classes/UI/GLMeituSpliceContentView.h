//
//  GLMeituSpliceContentView.h
//  Tuotuo
//
//  Created by yangyong on 14-8-21.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLMeituSpliceContentView : UIScrollView

@property (nonatomic, strong) UIImageView *firstView;
@property (nonatomic, strong) UIImageView *secondView;
@property (nonatomic, strong) UIImageView *thirdView;
@property (nonatomic, strong) UIImageView *fourthView;
@property (nonatomic, strong) UIImageView *fifthView;

@property (nonatomic, strong) NSArray           *assets;
@property (nonatomic, strong) NSMutableArray    *contentViewArray;
@property (nonatomic, strong) NSString          *styleFileName;
@property (nonatomic, assign) NSInteger         styleIndex;
@property (nonatomic, strong) NSDictionary      *styleDict;

@property (nonatomic, strong) UIImageView       *boardImageView;

- (void)initData;
- (void)setBoarderImage:(UIImage *)boarderImage;

@end
