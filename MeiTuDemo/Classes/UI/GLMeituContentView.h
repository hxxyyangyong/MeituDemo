//
//  GLMeituContentView.h
//  Tuotuo
//
//  Created by yangyong on 14-8-20.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeituImageEditView.h"

@protocol  GLMeituContentViewDelegate;
@interface GLMeituContentView : UIView<MeituImageEditViewDelegate>
{
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    
}
@property (nonatomic, strong) MeituImageEditView *firstView;
@property (nonatomic, strong) MeituImageEditView *secondView;
@property (nonatomic, strong) MeituImageEditView *thirdView;
@property (nonatomic, strong) MeituImageEditView *fourthView;
@property (nonatomic, strong) MeituImageEditView *fifthView;

@property (nonatomic, strong) NSMutableArray           *assets;
@property (nonatomic, strong) NSMutableArray    *contentViewArray;
@property (nonatomic, strong) NSString          *styleFileName;
@property (nonatomic, assign) NSInteger         styleIndex;
@property (nonatomic, strong) NSDictionary      *styleDict;

@property (nonatomic, strong) UIImageView       *boardImageView;
@property (nonatomic, assign) id<GLMeituContentViewDelegate> delegateMove;

//交换时的中间变量
@property (nonatomic, strong) MeituImageEditView *tempView;

- (void)setBackgroundColor:(UIColor *)backgroundColor posterImage:(UIImage *)posterImage;


+ (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale;
+ (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale;
+ (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale;

@end


@protocol  GLMeituContentViewDelegate <NSObject>

- (void)movedEditView;

@end

