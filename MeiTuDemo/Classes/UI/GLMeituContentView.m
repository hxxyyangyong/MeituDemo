//
//  GLMeituContentView.m
//  Tuotuo
//
//  Created by yangyong on 14-8-20.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//



#import "GLMeituContentView.h"

#define Duration 0.2


@implementation GLMeituContentView

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
    _firstView = [[MeituImageEditView alloc] initWithFrame:CGRectZero];
    _secondView = [[MeituImageEditView alloc] initWithFrame:CGRectZero];
    _thirdView = [[MeituImageEditView alloc] initWithFrame:CGRectZero];
    _fourthView = [[MeituImageEditView alloc] initWithFrame:CGRectZero];
    _fifthView = [[MeituImageEditView alloc] initWithFrame:CGRectZero];
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
    
    
    _boardImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_boardImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_boardImageView];
    
}

- (void)setAssets:(NSMutableArray *)assets
{
    _assets = [NSMutableArray arrayWithArray:assets];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor posterImage:(UIImage *)posterImage
{
    
    if (posterImage) {
        [_boardImageView setImage:posterImage];
        self.backgroundColor = backgroundColor;
    }else{
        [_boardImageView setImage:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
}


/**
 *  设置不同的样式
 *
 *  @param index 样式的选择
 */
- (void)setStyleIndex:(NSInteger)index
{
    _styleIndex = index;
    _styleFileName = nil;
    NSString *picCountFlag = @"";
    switch (_assets.count) {
        case 2:
            picCountFlag = @"two";
            break;
        case 3:
            picCountFlag = @"three";
            break;
        case 4:
            picCountFlag = @"four";
            break;
        case 5:
            picCountFlag = @"five";
            break;
        default:
            break;
    }
    if (![picCountFlag isEqualToString:@""]) {
        _styleFileName = [NSString stringWithFormat:@"number_%@_style_%d.plist",picCountFlag,_styleIndex];
        _styleDict = nil;
        _styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle].resourcePath
                                                                 stringByAppendingPathComponent:_styleFileName]];
        if (_styleDict) {
            [self resetAllView];
            [self resetStyle];
        }
    }
}



/**
 *  更换图片和frame的大小
 */
- (void)resetStyle
{
    if (_styleDict) {
        CGSize superSize = CGSizeFromString([[_styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
        superSize = [GLMeituContentView sizeScaleWithSize:superSize scale:2.0f];
        NSArray *subViewArray = [_styleDict objectForKey:@"SubViewArray"];
        for(int j = 0; j < [subViewArray count]; j++)
        {
            CGRect rect = CGRectZero;
            UIBezierPath *path = nil;
            ALAsset *asset = [self.assets objectAtIndex:j];
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];//fullScreenImage
            NSDictionary *subDict = [subViewArray objectAtIndex:j];
            if([subDict objectForKey:@"frame"])
            {
                rect = CGRectFromString([subDict objectForKey:@"frame"]);
                rect = [GLMeituContentView rectScaleWithRect:rect scale:2.0f];
                rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
                rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
                rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
                rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
            }
            rect = [self rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
            if ([subDict objectForKey:@"pointArray"]) {
                NSArray *pointArray = [subDict objectForKey:@"pointArray"];
                path = [UIBezierPath bezierPath];
                if (pointArray.count > 2) {//当点的数量大于2个的时候
                    //生成点的坐标
                    for(int i = 0; i < [pointArray count]; i++)
                    {
                        NSString *pointString = [pointArray objectAtIndex:i];
                        if (pointString) {
                            CGPoint point = CGPointFromString(pointString);
                            point = [GLMeituContentView pointScaleWithPoint:point scale:2.0f];
                            point.x = (point.x)*self.frame.size.width/superSize.width -rect.origin.x;
                            point.y = (point.y)*self.frame.size.height/superSize.height -rect.origin.y;
                            if (i == 0) {
                                [path moveToPoint:point];
                            }else{
                                [path addLineToPoint:point];
                            }
                        }
                        
                    }
                }else{
                    //当点的左边不能形成一个面的时候  至少三个点的时候 就是一个正规的矩形
                    //点的坐标就是rect的四个角
                    [path moveToPoint:CGPointMake(0, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
                    [path addLineToPoint:CGPointMake(0, rect.size.height)];
                }
                [path closePath];
            }
            
            if (j < [_contentViewArray count]) {
                MeituImageEditView *imageView = (MeituImageEditView *)[_contentViewArray objectAtIndex:j];
                imageView.tapDelegate = self;
                imageView.frame = rect;
                imageView.backgroundColor = [UIColor grayColor];
                imageView.realCellArea = path;
                [imageView setImageViewData:image rect:rect];
                imageView.oldRect = rect;
                //回调或者说是通知主线程刷新，
            }
        }
    }
    [self bringSubviewToFront:self.boardImageView];
}


/**
 *  计算frame 超出范围的等比缩小成相应大小
 *
 *  @param array
 *  @param superSize
 *
 *  @return
 */

- (CGRect)rectWithArray:(NSArray *)array andSuperSize:(CGSize)superSize
{
    CGRect rect = CGRectZero;
    CGFloat minX = INT_MAX;
    CGFloat maxX = 0;
    CGFloat minY = INT_MAX;
    CGFloat maxY = 0;
    for (int i = 0; i < [array count]; i++) {
        NSString *pointString = [array objectAtIndex:i];
        CGPoint point = CGPointFromString(pointString);
        if (point.x <= minX) {
            minX = point.x;
        }
        if (point.x >= maxX) {
            maxX = point.x;
        }
        if (point.y <= minY) {
            minY = point.y;
        }
        if (point.y >= maxY) {
            maxY = point.y;
        }
        rect = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    }
    rect = [GLMeituContentView rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
    return rect;
}

/**
 *  设置所有的样式
 */
- (void)resetAllView
{
    [self styleSettingWithView:_firstView];
    [self styleSettingWithView:_secondView];
    [self styleSettingWithView:_thirdView];
    [self styleSettingWithView:_fourthView];
    [self styleSettingWithView:_fifthView];

}

/**
 *  设置样式
 */
- (void)styleSettingWithView:(MeituImageEditView *)view
{
    view.frame = CGRectZero;
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor grayColor]];
    view.imageview.image = nil;
    view.realCellArea = nil;
    [view setImageViewData:nil];
    [view setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
    [view addGestureRecognizer:longGesture];
}

/**
 *  释放资源
 *
 *  @param view 
 */
- (void)releaseViewWith:(MeituImageEditView *)view
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
    _tempView = nil;
    
    NSLog(@"meitu content view release");
}


- (void)tapWithEditView:(MeituImageEditView *)sender
{
    if (_delegateMove && [_delegateMove respondsToSelector:@selector(movedEditView)]) {
        [_delegateMove movedEditView];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}


//长按换位的功能
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    
    MeituImageEditView *btn = (MeituImageEditView *)sender.view;
    NSLog(@"btn.tag::%d",btn.tag);
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [self bringSubviewToFront:btn];
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        //NSLog(@"center = %@",NSStringFromCGPoint(btn.center));
        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        NSLog(@"===%d",index);
        
        if (index<0)
        {
            contain = NO;
            _tempView = nil;
        }
        else
        {
            if (index != -1) {
                _tempView = _contentViewArray[index];
            }

            [UIView animateWithDuration:Duration animations:^{
                
//                CGPoint temp = CGPointZero;
//                MeituImageEditView *button = _contentViewArray[index];
//                temp = button.center;
//                button.center = originPoint;
//                btn.center = temp;
//                originPoint = btn.center;
//                contain = YES;
            }];
        }
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
//                btn.center = originPoint;
                if (_tempView) {
                    [self exchangeFromIndex:btn.tag-1 toIndex:_tempView.tag-1];
                }else{
                
                    [btn setNotReloadFrame:btn.oldRect];
                }
            }
            _tempView = nil;
        }];
    }
}


- (void)exchangeFromIndex:(NSInteger)fIndex toIndex:(NSInteger)toIndex
{

    ALAsset *a = [_assets objectAtIndex:fIndex];
    ALAsset *b = [_assets objectAtIndex:toIndex];
    
    [_assets replaceObjectAtIndex:fIndex withObject:b];
    [_assets replaceObjectAtIndex:toIndex withObject:a];
    
    MeituImageEditView *fromView = [_contentViewArray objectAtIndex:fIndex];
    MeituImageEditView *toView = [_contentViewArray objectAtIndex:toIndex];
    
    [_contentViewArray replaceObjectAtIndex:fIndex withObject:toView];
    [_contentViewArray replaceObjectAtIndex:toIndex withObject:fromView];

    MeituImageEditView *ttView = [[MeituImageEditView alloc] init];
    ttView.realCellArea = fromView.realCellArea;
    ttView.oldRect = fromView.oldRect;
    ttView.tag = fromView.tag;
    
    
    fromView.frame = toView.oldRect;
    fromView.realCellArea = toView.realCellArea;
    [fromView setImageViewData:[UIImage imageWithCGImage:a.defaultRepresentation.fullScreenImage] rect:toView.oldRect];
    fromView.tag = toView.tag;
    fromView.oldRect = toView.oldRect;

    toView.frame = ttView.oldRect;
    toView.realCellArea = ttView.realCellArea;
    [toView setImageViewData:[UIImage imageWithCGImage:b.defaultRepresentation.fullScreenImage] rect:ttView.oldRect];
    toView.tag = ttView.tag;
    toView.oldRect = ttView.oldRect;
    [self bringSubviewToFront:self.boardImageView];
    ttView = nil;

}



- (NSInteger)indexOfPoint:(CGPoint)point withButton:(MeituImageEditView *)btn
{
    for (NSInteger i = 0;i<_contentViewArray.count;i++)
    {
        MeituImageEditView *button = _contentViewArray[i];
        if (button != btn)
        {
            if (CGRectContainsPoint(button.oldRect, point))
            {
                return i;
            }
        }
    }
    return -1;
}




+ (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x/scale;
    retRect.origin.y = rect.origin.y/scale;
    retRect.size.width = rect.size.width/scale;
    retRect.size.height = rect.size.height/scale;
    return  retRect;
}

+ (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/scale;
    retPointt.y = point.y/scale;
    return  retPointt;
}


+ (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/scale;
    retSize.height = size.height/scale;
    return  retSize;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
