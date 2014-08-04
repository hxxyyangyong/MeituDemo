//
//  SharedImageViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-4-25.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "SharedImageViewController.h"
#import "SUIModalActionSheet.h"
@interface SharedImageViewController ()

@property (nonatomic, assign) long long recordResourceId;

@end

@implementation SharedImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    }
    self.recordResourceId = -100;
    [self initResource];
    [self initNavgationBar];
}







- (void)initResource
{
    self.view.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - iOS7AddStatusHeight)];
    [self.view addSubview:_contentView];
    CGRect rect = CGRectZero;
    rect.origin.x = 0;
    rect.origin.y = 0;
    UIImage *image = self.image;
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    if (width > _contentView.frame.size.width) {
        rect.size.width = _contentView.frame.size.width;
        rect.size.height = height*(_contentView.frame.size.width /width);
    }else{
        rect.size.width = width;
        rect.size.height = height;
    }
    
    rect.origin.x = (_contentView.frame.size.width - rect.size.width)/2.0f;
    if (rect.size.height < self.contentView.frame.size.height) {
        rect.origin.y = (_contentView.frame.size.height - rect.size.height)/2.0f;
    }
    
    _sharedImageView = [[UIImageView alloc] initWithFrame:rect];
    _sharedImageView.image = image;
    [_contentView addSubview:_sharedImageView];
    _contentView.contentSize = CGSizeMake(_contentView.frame.size.width, rect.size.height);
}


- (void)initNavgationBar
{
    self.title = D_LocalizedCardString(@"nav_title_preview");
    UIButton *preViewButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [preViewButton setTitle:@"提交" forState:UIControlStateNormal];
    [preViewButton addTarget:self
                      action:@selector(preViewBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preViewItem = [[UIBarButtonItem alloc] initWithCustomView:preViewButton];
    self.navigationItem.rightBarButtonItem = preViewItem;
}

- (void)preViewBtnAction:(id)sender
{
    SUIModalActionSheet *sendSelectSheet = [[SUIModalActionSheet alloc] initWithTitle:nil
                                                                             delegate:nil
                                                                    cancelButtonTitle:D_LocalizedCardString(@"Button_Cancel")
                                                               destructiveButtonTitle:nil
                                                                    otherButtonTitles:@"保存到相册",
                                            @"在做一张", nil];
    [sendSelectSheet showInView:self.view];
    int buttonIndex = sendSelectSheet._buttonIndex;
    if (buttonIndex == 0) {
        [self saveImageToAblm];
        
    }else if (buttonIndex == 1) {
    
        [self againCreate];
    }else{
    
    }
  
}


- (void)saveImageToAblm
{
    [self saveTapHandler];
}
-(void) saveTapHandler{
    [[LoadingViewManager sharedInstance] showText:@"正在保存" inView:self.view];
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}


#pragma mark - savePhotoAlbumDelegate
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"恭喜";
        message = @"成功保存到相册";
    } else {
        title = @"失败";
        message = [error description];
    }
    [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
    [[LoadingViewManager sharedInstance] showHUDWithText:message inView:self.view duration:0.5f];

}




- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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


#pragma mark
#pragma mark 再做一张

- (void)againCreate
{
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc class] == [ZYQAssetGroupViewController class]) {
            [vc.navigationController popToRootViewControllerAnimated:NO];
            [vc.parentViewController dismissViewControllerAnimated:NO completion:^{
            }];
            return;
        }else if([vc class] == [HomeMenuViewController class]){
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

#pragma mark
#pragma mark 去卡秀看看

- (void)gotoCardShow
{
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc class] == [ZYQAssetGroupViewController class]) {
            [vc.navigationController popViewControllerAnimated:NO];
            [vc.parentViewController dismissViewControllerAnimated:NO completion:^{
                ZYQAssetPickerController *tempVC = (ZYQAssetPickerController *)vc.parentViewController;
                [tempVC.vc.navigationController popViewControllerAnimated:NO];
            }];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
