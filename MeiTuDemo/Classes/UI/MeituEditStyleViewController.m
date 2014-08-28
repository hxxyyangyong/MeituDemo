//
//  MeituEditStyleViewController.m
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "MeituEditStyleViewController.h"
#import "AppDelegate.h"
@interface MeituEditStyleViewController ()<GLMeituContentViewDelegate>

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
        [self initData];
        _isFirst = NO;
    }
    [D_Main_Appdelegate hiddenPreView];


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)initResource
{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGSize contentSize = [self calcContentSize];
    
    self.contentView =  [[UIScrollView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - contentSize.width)/2.0f, (self.view.frame.size.height- 33 - 44-iOS7AddStatusHeight - contentSize.height)/2.0f, contentSize.width,contentSize.height)];
    [self.view addSubview:_contentView];
    
    self.meituContentView = [[GLMeituContentView alloc] initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 self.contentView.frame.size.width,
                                                                                 self.contentView.frame.size.height)];
    self.meituContentView.delegateMove = self;
    [self.contentView addSubview:self.meituContentView];
    
    
    self.spliceView = [[GLMeituSpliceContentView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*2,
                                                                                 0,
                                                                                 self.contentView.frame.size.width,
                                                                                 self.contentView.frame.size.height)];
    [self.contentView addSubview:self.spliceView];
    
    
    [self.contentView setPagingEnabled:YES];
    [self.contentView setScrollEnabled:NO];
    [self.contentView setContentSize:CGSizeMake(self.contentView.frame.size.width*3, self.contentView.frame.size.height)];
    [self.contentView setShowsVerticalScrollIndicator:NO];
    [self.contentView setShowsHorizontalScrollIndicator:NO];
    [self initBoardAndEditView];
    [self initToolbarView];
   
}


- (void)contentResetSizeWithCalc:(BOOL)calc
{
//    if (calc) {
//        _contentView.frame = CGRectMake((self.view.frame.size.width - [self calcContentSize].width)/2.0f, (self.view.frame.size.height - 33 - [self calcContentSize].height)/2.0f, [self calcContentSize].width, [self calcContentSize].height);
//        _contentView.contentSize = self.contentView.frame.size;
//
//    }else{
//        self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 33);
//    }
}


- (CGSize)calcContentSize
{
    CGSize retSize = CGSizeZero;
    //CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight);
    CGFloat size_width = self.view.frame.size.width;
    CGFloat size_height = size_width * 4 /3.0f;
    if (size_height >= (self.view.frame.size.height- iOS7AddStatusHeight - 44 -34)) {
        size_height = self.view.frame.size.height- iOS7AddStatusHeight - 44 - 34;
        size_width = size_height * 3/4.0f;
    }
    retSize.width = size_width;
    retSize.height = size_height;
    return  retSize;

}




- (void)initData
{
    [self.meituContentView setAssets:self.assets];
    [[LoadingViewManager sharedInstance] showLoadingViewInView:self.view withText:@"正在处理"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.meituContentView setStyleIndex:1];
        [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
    });
}



- (void)initNavgationBar
{
    self.title = D_LocalizedCardString(@"card_select_image_pingtu");
    self.navigationItem.backBarButtonItem = nil;
    UIButton *backButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton setTitle:[NSString stringWithFormat:@" %@",D_LocalizedCardString(@"Button_Back")] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_ios7_back"] forState:UIControlStateNormal];
    
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backButton addTarget:self
                      action:@selector(backButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];

    if(isIOS7){
        negativeSpacer.width = -8;
    }else{
        negativeSpacer.width = 0;
    }
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backButtonItem, nil];
    
    
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

//    [self.boardbutton setBackgroundColorNormal:[[UIColor colorWithHexString:@"#1fbba6"] colorWithAlphaComponent:0.9] highlightedColor:[[UIColor colorWithHexString:@"#03917e"] colorWithAlphaComponent:0.9]];
//    
//    [self.editbutton setBackgroundColorNormal:[[UIColor colorWithHexString:@"#f47a75"] colorWithAlphaComponent:0.9] highlightedColor:[[UIColor colorWithHexString:@"#ce5b56"] colorWithAlphaComponent:0.9]];
    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_normal"] forState:UIControlStateNormal];
    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_highlight"] forState:UIControlStateHighlighted];
    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_highlight"] forState:UIControlStateSelected];
    
    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_normal"] forState:UIControlStateNormal];
    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_highlight"] forState:UIControlStateHighlighted];
    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_highlight"] forState:UIControlStateSelected];
    
    
    
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
    [self initPosterView];
    [self.view addSubview:_bottomControlView];
    [self.bottomControlView setContentSize:CGSizeMake(self.bottomControlView.frame.size.width *2, _bottomControlView.frame.size.height)];
    [self.bottomControlView setPagingEnabled:YES];
    [self.bottomControlView setScrollEnabled:NO];
    [_bottomControlView setHidden:YES];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44-iOS7AddStatusHeight - 33, self.view.frame.size.width, 33)];
    [_bottomView setBackgroundColor:[[UIColor colorWithHexString:@"#1d1d1d"] colorWithAlphaComponent:0.9]];
    
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
            if (_selectControlButton != _storyboardButton) {
                [self.contentView setContentOffset:CGPointMake(0, 0) animated:YES];
            }

            self.bottomControlView.contentOffset = CGPointMake(0, 0);
            [self showStoryboardAndPoster];
        }
            break;
        case 2:
        {
            [self hiddenBoardButton];
            if (_selectControlButton != _posterButton) {
                [self freeStyleCreate];
            }
            self.bottomControlView.contentOffset = CGPointMake(self.bottomControlView.frame.size.width, 0);
            [self showStoryboardAndPoster];
        }
            break;
        case 3:
        {
            [self showBoardButton];
            if (_selectControlButton != _spliceButton) {
                [self spliceAction];
            }
            
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
        
        [_meituContentView setBackgroundColor:[UIColor whiteColor] posterImage:[UIImage imageNamed:@"testBoder_1.png"]];
//        GLMeitoPosterSelectViewController *posterVC = [[GLMeitoPosterSelectViewController alloc] init];
//        posterVC.delegateSelectPet = self;
//        posterVC.blurImage = [ImageUtility cutImageWithView:self.view];
//        [self presentViewController:posterVC animated:YES completion:^{
//        }];
        
    }else if(_selectControlButton.tag == 3){
        [_spliceView setBoarderImage:[UIImage imageNamed:@"testBoder_2.png"]];
//        GLMeitoBorderSelectViewController *posterVC = [[GLMeitoBorderSelectViewController alloc] init];
//        posterVC.delegateSelectPet = self;
//        posterVC.blurImage = [ImageUtility cutImageWithView:self.view];
//        [self presentViewController:posterVC animated:YES completion:^{
//        }];
    }
    
}

- (void)editButtonAction:(id)sender
{
    [D_Main_Appdelegate showPreView];
    [self.navigationController popViewControllerAnimated:YES];
}



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



- (UIImage *)cutImageWithView:(UIView *)contentView
{
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(contentView.frame.size, NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(contentView.frame.size);
    }
    
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    static int index = 0;
    //    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"cut_%@/%d.png",[NSDate date],index];
    //    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
    //        NSLog(@"Succeeded! /n %@",path);
    //    }
    //    else {
    //        NSLog(@"Failed!");
    //    }
    return image;
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



#pragma mark 
#pragma mark 分镜中图的移动

- (void)movedEditView
{
    [self hiddenStoryboardAndPoster];
}




#pragma mark
#pragma mark 分镜-边框选择 GLMeitoPosterSelectViewControllerDelegate
- (void)didSelectedWithPoster:(NSDictionary *)posterDict
{


}

- (void)didSelectedWithPoster:(NSDictionary *)posterDict isEmpty:(BOOL)isEmpty
{
    
    if (isEmpty) {
        [_meituContentView setBackgroundColor:[UIColor whiteColor] posterImage:nil];
    }else{
        UIImage *posterImage = nil;
        if ([posterDict objectForKey:@"PosterImagePath"]) {
            posterImage = [UIImage imageWithContentsOfFile:[posterDict objectForKey:@"PosterImagePath"]];
            posterImage = [self originImage:posterImage scaleToSize:self.meituContentView.frame.size];
        }
        NSString *boardColor = [posterDict objectForKey:@"BoardColor"];
        if (boardColor) {
            @try {
                self.selectedBoardColor = [UIColor colorWithHexString:boardColor];
                [_meituContentView setBackgroundColor:self.selectedBoardColor  posterImage:posterImage];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
    }
    
}


#pragma mark 
#pragma mark 拼接的边框选择 GLMeitoBorderSelectViewControllerDelegate
- (void)didSelectedWithBorder:(NSDictionary *)borderDict
{


}
- (void)didSelectedWithBorder:(NSDictionary *)borderDict isEmpty:(BOOL)isEmpty
{
    if (isEmpty) {
        [self.spliceView setBoarderImage:nil];
    }else{
        if ([borderDict objectForKey:@"BorderImagePath"]) {
            UIImage *posterImage = [UIImage imageWithContentsOfFile:[borderDict objectForKey:@"BorderImagePath"]];
            [self.spliceView setBoarderImage:posterImage];
        }
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
    [[LoadingViewManager sharedInstance] showLoadingViewInView:self.view withText:@"正在处理"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetViewByStyleIndex:styleIndex imageCount:self.assets.count];
        [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
    });
}


- (void)initPosterView
{
    
}


#pragma mark
#pragma mark 自由模式图的移动

- (void)stickerIsEdit
{
    [self hiddenStoryboardAndPoster];
}






#pragma mark
#pragma mark 屏幕touch的监听 便于隐藏底部的bar
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self hiddenStoryboardAndPoster];
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
//    [_contentView addSubview:self.bringPosterView];
//    [_contentView bringSubviewToFront:self.bringPosterView];
//    [_contentView addSubview:self.freeBgView];
//    [_contentView sendSubviewToBack:self.freeBgView];
}





#pragma mark
#pragma mark 不同的分镜的样式

- (void)resetViewByStyleIndex:(NSInteger)index imageCount:(NSInteger)count
{

    [self.contentView setContentOffset:CGPointMake(0, 0) animated:YES];
    @synchronized(self){
        self.selectStoryBoardStyleIndex = index;
        [self.meituContentView setStyleIndex:self.selectStoryBoardStyleIndex];
    }
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
    rect = [GLMeituContentView rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * _contentView.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * _contentView.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * _contentView.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * _contentView.frame.size.height/superSize.height;
    
    return rect;
}



#pragma mark
#pragma mark 自由模式中的选择

- (void)freeStyleCreate
{

}

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
        
        if (_spliceView.assets == nil) {
            [_spliceView setAssets:self.assets];

            [[LoadingViewManager sharedInstance] showLoadingViewInView:self.view withText:@"正在处理"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_spliceView initData];
                [self.contentView setContentOffset:CGPointMake(_contentView.bounds.size.width*2, 0) animated:YES];
                [[LoadingViewManager sharedInstance] removeLoadingView:self.view];

            });
            
        }else{
                [self.contentView setContentOffset:CGPointMake(self.contentView.frame.size.width*2, 0) animated:YES];
        }
    }
   
}


/**
 *  收起边框按钮
 */
- (void)hiddenBoardButton
{

    _boardbutton.hidden = YES;
    CGRect rect = _editbutton.frame;
    rect.origin.x = (_boardAndEditView.frame.size.width - _boardbutton.frame.size.width)/2.0f;
    _editbutton.frame = rect;
    
}

/**
 *  显示边框 按钮
 */
- (void)showBoardButton
{
    _boardbutton.hidden = NO;
   _boardbutton.frame = CGRectMake(75, 0, 75, 30);
    _editbutton.frame  = CGRectMake(_boardAndEditView.frame.size.width-75-75, 0, 75, 30);
    
}





//#pragma mark 
//#pragma mark  坐标的转换 将2倍的像素转化成一倍的
//
//- (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale
//{
//    CGRect retRect = CGRectZero;
//    retRect.origin.x = rect.origin.x/2.0f;
//        retRect.origin.y = rect.origin.y/2.0f;
//        retRect.size.width = rect.size.width/2.0f;
//        retRect.size.height = rect.size.height/2.0f;
//    return  retRect;
//}
//
//- (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale
//{
//    CGPoint retPointt = CGPointZero;
//    retPointt.x = point.x/2.0f;
//    retPointt.y = point.y/2.0f;
//    return  retPointt;
//}
//
//
//- (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale
//{
//    CGSize retSize = CGSizeZero;
//    retSize.width = size.width/2.0f;
//    retSize.height = size.height/2.0f;
//    return  retSize;
//}



#pragma mark
#pragma mark --NavgationBar BackButton And PreviewAction

- (void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [D_Main_Appdelegate showPreView];
    [self releseViewResource];
}

- (void)releseViewResource
{
    [_meituContentView removeFromSuperview];
    _meituContentView = nil;
    
}



#pragma mark
#pragma mark 预览图

- (void)preViewBtnAction:(id)sender
{
    SharedImageViewController *sharedVC = [[SharedImageViewController alloc] init];
    switch (self.selectControlButton.tag) {
        case 1:
            sharedVC.image = [self cutImageWithView:self.meituContentView];
            break;
        case 2:
            break;
        case 3:
            sharedVC.image = [self captureScrollView:self.spliceView];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:sharedVC animated:YES];
}




- (void)dealloc
{
    
    
    
    _assets = nil;
    [_contentView removeFromSuperview];
    _contentView = nil;
    [_boardAndEditView removeFromSuperview];
    
    [_boardbutton removeFromSuperview];
    _boardbutton = nil;
    
    [_editbutton removeFromSuperview];
    _editbutton = nil;
    [_bottomView removeFromSuperview];
    _bottomView = nil;
    [_storyboardButton removeFromSuperview];
    _storyboardButton = nil;
    [_posterButton removeFromSuperview];
    _posterButton = nil;
    [_spliceButton removeFromSuperview];
    _spliceButton = nil;
    [_selectControlButton removeFromSuperview];
    _selectControlButton = nil;
    [_storyboardView removeFromSuperview];
    _storyboardView = nil;

    [_bottomControlView removeFromSuperview];
    _bottomControlView = nil;
    [_selectedStoryboardBtn removeFromSuperview];
    _selectedStoryboardBtn = nil;
    [_selectedPosterBtn removeFromSuperview];
    _selectedPosterBtn = nil;
    _selectedBoardColor = nil;
    [_meituContentView removeFromSuperview];
    _meituContentView = nil;
    [_spliceView removeFromSuperview];
    _spliceView = nil;
    NSLog(@"%@::::::::deallloc",[self class]);
    
    
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
