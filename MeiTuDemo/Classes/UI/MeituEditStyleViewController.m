//
//  MeituEditStyleViewController.m
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "MeituEditStyleViewController.h"
#import "AppDelegate.h"
@interface MeituEditStyleViewController ()<MeituImageEditViewDelegate>

@end

@implementation MeituEditStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        _buttonInfoArray = [NSArray array];
//        _buttonInfoArray = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.plist",[[NSBundle mainBundle] resourcePath],@"MoodButtonStyle"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.view.frame;
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    }
    self.selectStoryBoardStyleIndex = 1;
    [self initNavgationBar];
    [self initResource];
    _isFirst = YES;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    if (_isFirst) {
        [self contentResetSizeWithCalc:YES];
        [self initData];
        _isFirst = NO;
    }
    [D_Main_Appdelegate hiddenPreView];
//    [(CRNavigationController *)self.navigationController setCanDragBack:NO];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)initResource
{

    self.contentView =  [[UIScrollView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - [self calcContentSize].width)/2.0f, (self.view.frame.size.height - 2*44-iOS7AddStatusHeight - [self calcContentSize].height)/2.0f, [self calcContentSize].width, [self calcContentSize].height)];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_contentView];
    
    self.freeBgView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    [_freeBgView setBackgroundColor:[UIColor whiteColor]];
    [_contentView addSubview:_freeBgView];
    
    
    self.bringPosterView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    [_bringPosterView setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:_bringPosterView];
    [self initBoardAndEditView];
    [self initToolbarView];
   
}


- (void)contentResetSizeWithCalc:(BOOL)calc
{
    if (calc) {
        _contentView.frame = CGRectMake((self.view.frame.size.width - [self calcContentSize].width)/2.0f, (self.view.frame.size.height - 33 - [self calcContentSize].height)/2.0f, [self calcContentSize].width, [self calcContentSize].height);
        _contentView.contentSize = self.contentView.frame.size;

    }else{
        self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 33);
    }
}


- (CGSize)calcContentSize
{
    CGSize retSize = CGSizeZero;
    //CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight);
    CGFloat size_width = self.view.frame.size.width;
    CGFloat size_height = size_width * 4 /3.0f;
    if (size_height >= (self.view.frame.size.height-34)) {
        size_height = self.view.frame.size.height- 34;
        size_width = size_height * 3/4.0f;
    }
    retSize.width = size_width;
    retSize.height = size_height;
    return  retSize;

}




- (void)initData
{
    [self resetViewByStyleIndex:1 imageCount:[self.assets count]];
}



- (void)initNavgationBar
{
    self.title = D_LocalizedCardString(@"card_select_image_pingtu");
    self.navigationItem.backBarButtonItem = nil;
    UIButton *backButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backButton setTitle:D_LocalizedCardString(@"Button_Back") forState:UIControlStateNormal];
//    if (IOS7) {
//        [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [backButton setImage:[UIImage imageNamed:@"icon_ios7_back"] forState:UIControlStateNormal];
//    }
    [backButton addTarget:self
                      action:@selector(backButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UIButton *preViewButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [preViewButton setTitle:D_LocalizedCardString(@"nav_title_preview") forState:UIControlStateNormal];
    [preViewButton addTarget:self
                      action:@selector(preViewBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preViewItem = [[UIBarButtonItem alloc] initWithCustomView:preViewButton];
    self.navigationItem.rightBarButtonItem = preViewItem;
}





#pragma mark 
#pragma mark Bottom ToolBar

- (void)initBoardAndEditView
{
    self.boardAndEditView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44- iOS7AddStatusHeight - 33- 25 - 30, self.view.frame.size.width, 30)];
    [self.boardAndEditView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.boardAndEditView];
    
    self.boardbutton = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, 75, 30)];
    self.editbutton  = [[UIButton alloc] initWithFrame:CGRectMake(_boardAndEditView.frame.size.width-75-75, 0, 75, 30)];
    
    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_normal"] forState:UIControlStateNormal];
    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_highlight"] forState:UIControlStateHighlighted];
    
    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_normal"] forState:UIControlStateNormal];
    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_highlight"] forState:UIControlStateHighlighted];
    
    [self.boardbutton setTitle:D_LocalizedCardString(@"card_meitu_board") forState:UIControlStateNormal];
    [self.editbutton setTitle:D_LocalizedCardString(@"card_meitu_edit") forState:UIControlStateNormal];
    
    [self.boardbutton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.editbutton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [_boardbutton.layer setCornerRadius:15.0f];
    [_editbutton.layer setCornerRadius:15.0f];
    
    [_boardbutton setClipsToBounds:YES];
    [_editbutton setClipsToBounds:YES];
    
    [self.boardAndEditView addSubview:_boardbutton];
    [self.boardAndEditView addSubview:_editbutton];
    
    [_boardbutton addTarget:self action:@selector(boardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_editbutton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}






- (void)initToolbarView
{
    self.bottomControlView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44-iOS7AddStatusHeight - 33 - 50, self.view.frame.size.width, 50)];
    
    
    [self initStoryboardView];
    [self.view addSubview:_bottomControlView];
    [self.bottomControlView setContentSize:CGSizeMake(self.bottomControlView.frame.size.width *2, _bottomControlView.frame.size.height)];
    [self.bottomControlView setPagingEnabled:YES];
    [self.bottomControlView setScrollEnabled:NO];
    [_bottomControlView setHidden:YES];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44-iOS7AddStatusHeight - 33, self.view.frame.size.width, 33)];
    [_bottomView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.9]];
    
    _storyboardButton = [[UIButton alloc] init];
    [_storyboardButton setTitle:D_LocalizedCardString(@"card_meitu_storyboard")
                       forState:UIControlStateNormal];
    _posterButton = [[UIButton alloc] init];
    [_posterButton setTitle:D_LocalizedCardString(@"card_meitu_poster")
                   forState:UIControlStateNormal];
    _spliceButton = [[UIButton alloc] init];
    [_spliceButton setTitle:D_LocalizedCardString(@"card_meitu_splice")
                   forState:UIControlStateNormal];
    
    [_storyboardButton setTag:1];
    [_posterButton setTag:2];
    [_spliceButton setTag:3];
    
    
    [self controlButtonStyleSettingWithButton:_storyboardButton];
    [self controlButtonStyleSettingWithButton:_posterButton];
    [self controlButtonStyleSettingWithButton:_spliceButton];
    
    [_bottomView addSubview:_storyboardButton];
    [_bottomView addSubview:_posterButton];
    [_bottomView addSubview:_spliceButton];
    [self.view addSubview:_bottomView];
    [_storyboardButton setSelected:YES];
    _selectControlButton = _storyboardButton;
    
}
/**
 *  底部分镜，自由，拼接按钮的样式设置
 *  包括frame titlecolor 监听事件等
 *  @param sender 需要设置的按钮
 */
- (void)controlButtonStyleSettingWithButton:(UIButton *)sender
{
    
    sender.frame =  CGRectMake(_bottomView.frame.size.width/3.0f*(sender.tag-1), 0, _bottomView.frame.size.width/3.0f, _bottomView.frame.size.height);
    [sender.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [sender.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [sender.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [sender setTitleColor:[UIColor colorWithHexString:@"#cbcbcb"] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithHexString:@"#1fbba6"] forState:UIControlStateHighlighted];
    [sender setTitleColor:[UIColor colorWithHexString:@"#1fbba6"] forState:UIControlStateSelected];
    [sender addTarget:self action:@selector(bottomViewControlAction:) forControlEvents:UIControlEventTouchUpInside];

}

/**
 *  分镜，自由，拼接按钮的事件
 *  重置原来的view和按钮状态，显示新的view和按钮选中状态
 *  @param sender 点击的按钮
 */
- (void)bottomViewControlAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_selectControlButton setSelected:NO];
    //重置选中的view
    
   
    switch (button.tag) {
        case 1:
        {
            [self showBoardButton];
            [self contentResetSizeWithCalc:YES];
            if (_selectControlButton != _storyboardButton) {
                self.freeBgView.image = nil;
                self.freeBgView.backgroundColor = self.selectedBoardColor?self.selectedBoardColor:[UIColor whiteColor];
                [LoadingViewManager showLoadViewWithText:@"正在处理" andShimmering:YES andBlurEffect:YES inView:self.view];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [self contentRemoveView];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self resetViewByStyleIndex:self.selectStoryBoardStyleIndex imageCount:self.assets.count];
                        [LoadingViewManager hideLoadViewInView:self.view];
                    });
                    
                });
                
                [self.bringPosterView setHidden:NO];
            }
            
            self.bottomControlView.contentOffset = CGPointMake(0, 0);
            [self showStoryboardAndPoster];
        }
            break;
        case 2:
        {
            [self hiddenBoardButton];
            [self contentResetSizeWithCalc:YES];
            if (_selectControlButton != _posterButton) {
                self.freeBgView.image = nil;
                self.freeBgView.backgroundColor = [UIColor whiteColor];
//                [self freeStyleCreate];
            }
            self.bottomControlView.contentOffset = CGPointMake(self.bottomControlView.frame.size.width, 0);
            [self showStoryboardAndPoster];
            [self.bringPosterView setHidden:YES];
        }
            break;
        case 3:
        {
            [self contentResetSizeWithCalc:NO];
            [self showBoardButton];
            if (_selectControlButton != _spliceButton) {
                self.freeBgView.image = nil;
                self.freeBgView.backgroundColor = [UIColor whiteColor];
                [self spliceAction];
            }
            [self.bringPosterView setHidden:YES];
            [self hiddenStoryboardAndPoster];
        }
            break;
        default:
            break;
    }
    _selectControlButton = button;
    [button setSelected:YES];

}

- (void)showStoryboardAndPoster
{
    self.bottomControlView.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.bottomControlView.frame =  CGRectMake(0, self.view.frame.size.height  - 33 - 50, self.view.frame.size.width, 50);
                         _boardAndEditView.frame =  CGRectMake(0, self.view.frame.size.height  - 33 - 50 - 30 - 10, self.view.frame.size.width, 30);
                     } completion:^(BOOL finished) {
                         
                     }];
}


- (void)hiddenStoryboardAndPoster
{
    //重置选中的view

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.bottomControlView.frame =  CGRectMake(0, self.view.frame.size.height  - 33, self.view.frame.size.width, 1);
                         _boardAndEditView.frame =  CGRectMake(0, self.view.frame.size.height - 33- 30- 25, self.view.frame.size.width, 30);
                     } completion:^(BOOL finished) {
                         [self.bottomControlView setHidden:YES];
                     }];


}


- (void)boardButtonAction:(id)sender
{
    
    if (_selectControlButton.tag == 1) {
        
        UIImage *posterImage = [UIImage imageNamed:@"testBoder_1"];
            posterImage = [self originImage:posterImage scaleToSize:self.contentView.frame.size];
            self.bringPosterView.image = [posterImage stretchableImageWithLeftCapWidth:posterImage.size.width/4.0f topCapHeight:160];
            self.bringPosterView.frame = self.bringPosterView.frame;
            
            
        NSString *boardColor = @"#FED597";
        if (boardColor) {
            @try {
                self.freeBgView.image = nil;
                self.freeBgView.backgroundColor = [UIColor colorWithHexString:boardColor];
                self.selectedBoardColor = [UIColor colorWithHexString:boardColor];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
        
    }else if(_selectControlButton.tag == 3){
        
        self.freeBgView.image  = nil;
        UIImage *posterImage = [UIImage imageNamed:@"testBoder_2"];
        self.freeBgView.backgroundColor = [UIColor colorWithPatternImage:posterImage];
    }
    
}

- (void)editButtonAction:(id)sender
{
    [D_Main_Appdelegate showPreView];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark GLMeitoPosterSelectViewControllerDelegate

-(UIImage*)originImage:(UIImage *)image   scaleToSize:(CGSize)size
{
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	
	// 返回新的改变大小后的图片
	return scaledImage;
}


- (void)didSelectedWithPoster:(NSDictionary *)posterDict
{
    if ([posterDict objectForKey:@"PosterImagePath"]) {
        UIImage *posterImage = [UIImage imageWithContentsOfFile:[posterDict objectForKey:@"PosterImagePath"]];
        posterImage = [self originImage:posterImage scaleToSize:self.contentView.frame.size];
        self.bringPosterView.image = [posterImage stretchableImageWithLeftCapWidth:posterImage.size.width/4.0f topCapHeight:160];
        self.bringPosterView.frame = self.bringPosterView.frame;
        
        
    }
    NSString *boardColor = [posterDict objectForKey:@"BoardColor"];
    if (boardColor) {
        @try {
            self.freeBgView.image = nil;
            self.freeBgView.backgroundColor = [UIColor colorWithHexString:boardColor];
            self.selectedBoardColor = [UIColor colorWithHexString:boardColor];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }

}


#pragma mark 
#pragma mark GLMeitoBorderSelectViewControllerDelegate
- (void)didSelectedWithBorder:(NSDictionary *)borderDict
{
    self.freeBgView.image  = nil;
    if ([borderDict objectForKey:@"BorderImagePath"]) {
        UIImage *posterImage = [UIImage imageWithContentsOfFile:[borderDict objectForKey:@"BorderImagePath"]];
        self.freeBgView.backgroundColor = [UIColor colorWithPatternImage:posterImage];
    }
}





- (void)initStoryboardView;
{
    _storyboardView = [[GLStoryboardSelectView alloc] initWithFrame:CGRectMake(0, 0, self.bottomControlView.frame.size.width, self.bottomControlView.frame.size.height) picCount:[self.assets count]];
    [_storyboardView setBackgroundColor:[[UIColor colorWithHexString:@"#454545"] colorWithAlphaComponent:0.6]];
    _storyboardView.delegateSelect = self;
    [_bottomControlView addSubview:_storyboardView];
}

/**
 *  分镜的选择
 *
 *  @param sender
 */
- (void)didSelectedStoryboardPicCount:(NSInteger)picCount styleIndex:(NSInteger)styleIndex
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[LoadingViewManager sharedInstance] showLoadingViewInView:self.view withText:@"正在处理"];
        [self contentRemoveView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self resetViewByStyleIndex:styleIndex imageCount:self.assets.count];
        });
        
    });
}




#pragma mark
#pragma mark 屏幕touch的监听 便于隐藏底部的bar
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenStoryboardAndPoster];
}

- (void)tapWithEditView:(MeituImageEditView *)sender
{
    [self hiddenStoryboardAndPoster];
}


- (void)contentRemoveView
{
    for (UIView *subView in _contentView.subviews) {
        [subView removeFromSuperview];
    }
    [_contentView addSubview:self.bringPosterView];
    [_contentView bringSubviewToFront:self.bringPosterView];
    [_contentView addSubview:self.freeBgView];
    [_contentView sendSubviewToBack:self.freeBgView];
}





#pragma mark
#pragma mark 不同的分镜的样式

- (void)resetViewByStyleIndex:(NSInteger)index imageCount:(NSInteger)count
{

    @synchronized(self){
        self.selectStoryBoardStyleIndex = index;
        NSString *picCountFlag = @"";
        NSString *styleIndex = @"";
        switch (count) {
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
        
        switch (index) {
            case 1:
                styleIndex = @"1";
                break;
            case 2:
                styleIndex = @"2";
                break;
            case 3:
                styleIndex = @"3";
                break;
            case 4:
                styleIndex = @"4";
                break;
            case 5:
                styleIndex = @"5";
                break;
            case 6:
                styleIndex = @"6";
                break;
            default:
                break;
        }
        
        NSString *styleName = [NSString stringWithFormat:@"number_%@_style_%@.plist",picCountFlag,styleIndex];
        NSDictionary *styleDict = [NSDictionary dictionaryWithContentsOfFile:
                                   [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:styleName]];
        if (styleDict) {
            CGSize superSize = CGSizeFromString([[styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
            superSize = [self sizeScaleWithSize:superSize scale:2.0f];
            
            NSArray *subViewArray = [styleDict objectForKey:@"SubViewArray"];
            
            
            
            for(int j = 0; j < [subViewArray count]; j++)
            {
                CGRect rect = CGRectZero;
                UIBezierPath *path = nil;
                ALAsset *asset = [self.assets objectAtIndex:j];
                UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                
                NSDictionary *subDict = [subViewArray objectAtIndex:j];
                if([subDict objectForKey:@"frame"])
                {
                    rect = CGRectFromString([subDict objectForKey:@"frame"]);
                    rect = [self rectScaleWithRect:rect scale:2.0f];
                    rect.origin.x = rect.origin.x * _contentView.frame.size.width/superSize.width;
                    rect.origin.y = rect.origin.y * _contentView.frame.size.height/superSize.height;
                    rect.size.width = rect.size.width * _contentView.frame.size.width/superSize.width;
                    rect.size.height = rect.size.height * _contentView.frame.size.height/superSize.height;
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
                                point = [self pointScaleWithPoint:point scale:2.0f];
                                point.x = (point.x)*_contentView.frame.size.width/superSize.width -rect.origin.x;
                                point.y = (point.y)*_contentView.frame.size.height/superSize.height -rect.origin.y;
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
                
                
                
                MeituImageEditView *imageView = [[MeituImageEditView alloc] initWithFrame:rect];
                [imageView setClipsToBounds:YES];
                [imageView setBackgroundColor:[UIColor grayColor]];
                imageView.tag = j;
                imageView.realCellArea = path;
                imageView.tapDelegate = self;
                [imageView setImageViewData:image];
                //回调或者说是通知主线程刷新，
                [_contentView addSubview:imageView];
                imageView = nil;
                
                
            }
        }
        [_contentView bringSubviewToFront:self.bringPosterView];
        _contentView.contentSize = _contentView.frame.size;
        self.bringPosterView.frame = CGRectMake(0, 0, _contentView.contentSize.width, _contentView.contentSize.height);
    }
    [self performSelector:@selector(hiddenWaitView) withObject:nil afterDelay:1.0];
    
}

- (void)hiddenWaitView
{
    [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
}



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
    rect = [self rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * _contentView.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * _contentView.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * _contentView.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * _contentView.frame.size.height/superSize.height;
    
    return rect;
}


- (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale
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

- (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/scale;
    retPointt.y = point.y/scale;
    return  retPointt;
}


- (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/scale;
    retSize.height = size.height/scale;
    return  retSize;
}



#pragma mark
#pragma mark 自由模式中的选择


//- (void)stickerViewDidBeginEditing:(ZDStickerView *)sticker
//{
//    [sticker showEditingHandles];
//}
//
//- (void)stickerViewDidEndEditing:(ZDStickerView *)sticker
//{
//    [sticker hideEditingHandles];
//}
//








#pragma mark
#pragma mark 拼接
- (void)spliceAction
{
    @synchronized(self){
        [self contentRemoveView];
        CGRect rect = CGRectZero;
        rect.origin.x = 0;
        rect.origin.y = 10;
        for (int i = 0; i < [self.assets count]; i++) {
            ALAsset *asset = [self.assets objectAtIndex:i];
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            CGFloat height = image.size.height;
            CGFloat width = image.size.width;
            rect.size.width = _contentView.frame.size.width - 20;
            rect.size.height = height*((_contentView.frame.size.width - 20)/width);
            rect.origin.x = 10;//(_contentView.frame.size.width - rect.size.width)/2.0f + 10;
            //        rect.size.width = rect.size.width - 20;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            rect.origin.y += rect.size.height+5;
            imageView.image = image;
            //      [imageView.layer setBorderWidth:2.0f];
            //      [imageView.layer setBorderColor:[UIColor clearColor].CGColor];
            //      self.selectedBoardColor == nil ?[UIColor whiteColor].CGColor:self.selectedBoardColor.CGColor];
            [_contentView addSubview:imageView];
        }
        _contentView.contentSize = CGSizeMake(_contentView.frame.size.width, rect.origin.y+5);
        
        self.freeBgView.frame = CGRectMake(0, 0, _contentView.contentSize.width, _contentView.contentSize.height);
    }
   
}



- (void)hiddenBoardButton
{

    _boardbutton.hidden = YES;
    CGRect rect = _editbutton.frame;
    rect.origin.x = (_boardAndEditView.frame.size.width - _boardbutton.frame.size.width)/2.0f;
    _editbutton.frame = rect;
    
}

- (void)showBoardButton
{
    _boardbutton.hidden = NO;
   _boardbutton.frame = CGRectMake(75, 0, 75, 30);
    _editbutton.frame  = CGRectMake(_boardAndEditView.frame.size.width-75-75, 0, 75, 30);
    
}







#pragma mark
#pragma mark --NavgationBar BackButton And PreviewAction

- (void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [D_Main_Appdelegate showPreView];
}


- (void)preViewBtnAction:(id)sender
{
    SharedImageViewController *sharedVC = [[SharedImageViewController alloc] init];
    sharedVC.image = [self captureScrollView:self.contentView];
    [self.navigationController pushViewController:sharedVC animated:YES];
}


- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(scrollView.contentSize);
    }
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
