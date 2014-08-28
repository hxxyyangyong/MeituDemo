//
//  GLMeituSpliceContentView.m
//  Tuotuo
//
//  Created by yangyong on 14-8-21.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLMeituSpliceContentView.h"

@implementation GLMeituSpliceContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initResource];
    }
    return self;
}



- (void)initResource
{
    self.backgroundColor = [UIColor whiteColor];
    _boardImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_boardImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_boardImageView];
    
    
    _firstView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _secondView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _thirdView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fourthView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fifthView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self resetAllView];
    if (_contentViewArray == nil) {
        _contentViewArray = [NSMutableArray arrayWithCapacity:5];
    }
    
    _firstView.tag = 1;
    _secondView.tag = 2;
    _thirdView.tag = 3;
    _fourthView.tag = 4;
    _fifthView.tag = 5;
    
    
    [_contentViewArray addObject:_firstView];
    [_contentViewArray addObject:_secondView];
    [_contentViewArray addObject:_thirdView];
    [_contentViewArray addObject:_fourthView];
    [_contentViewArray addObject:_fifthView];
    
    
    [self addSubview:_firstView];
    [self addSubview:_secondView];
    [self addSubview:_thirdView];
    [self addSubview:_fourthView];
    [self addSubview:_fifthView];
    
    
}

- (void)resetAllView
{
    [self styleSettingWithView:_firstView];
    [self styleSettingWithView:_secondView];
    [self styleSettingWithView:_thirdView];
    [self styleSettingWithView:_fourthView];
    [self styleSettingWithView:_fifthView];
    
}


- (void)setBoarderImage:(UIImage *)boarderImage;
{
    [_boardImageView setBackgroundColor:[UIColor colorWithPatternImage:boarderImage]];
}


- (void)initData
{
    
    CGRect rect = CGRectZero;
    rect.origin.x = 0;
    rect.origin.y = 10;
    for (int i = 0; i < [self.assets count]; i++) {
        ALAsset *asset = [self.assets objectAtIndex:i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        CGFloat height = image.size.height;
        CGFloat width = image.size.width;
        rect.size.width = self.frame.size.width - 20;
        rect.size.height = height*((self.frame.size.width - 20)/width);
        rect.origin.x = 10;//(_contentView.frame.size.width - rect.size.width)/2.0f + 10;
        //        rect.size.width = rect.size.width - 20;
        if (i < [self.contentViewArray count]) {
            UIImageView *imageView = (UIImageView *)[self.contentViewArray objectAtIndex:i];
            imageView.frame = rect;
            rect.origin.y += rect.size.height+5;
            imageView.image = image;
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, rect.origin.y+5);
    self.boardImageView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
}



- (void)styleSettingWithView:(UIImageView *)view
{
    view.frame = CGRectZero;
}


- (void)releaseViewWith:(UIImageView *)view
{
    [view removeFromSuperview];
    view = nil;
}

- (void)dealloc
{
    [_contentViewArray removeAllObjects];
    _contentViewArray = nil;
    _assets = nil;
    _styleFileName = nil;
    _styleDict = nil;
    
    [self releaseViewWith:_firstView];
    [self releaseViewWith:_secondView];
    [self releaseViewWith:_thirdView];
    [self releaseViewWith:_fourthView];
    [self releaseViewWith:_fifthView];
    
    [_boardImageView removeFromSuperview];
    _boardImageView = nil;

    NSLog(@"meitu content view release");
}

@end
