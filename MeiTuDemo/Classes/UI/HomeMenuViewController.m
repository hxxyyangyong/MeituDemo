//
//  HomeMenuViewController.m
//  MeiTuDemo
//
//  Created by yangyong on 14-8-4.
//  Copyright (c) 2014年 zhuofeng. All rights reserved.
//

#import "HomeMenuViewController.h"
#import "AppDelegate.h"
@interface HomeMenuViewController ()

@end

@implementation HomeMenuViewController

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
    // Do any additional setup after loading the view.
    [self initResource];
    self.title = @"拼图";
}

- (void)initResource
{
    
    _meituMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 103, 105)];
    [_meituMenuButton setImage:[UIImage imageNamed:@"icon_home_puzzle"] forState:UIControlStateNormal];
    [_meituMenuButton setTitle:@"拼图" forState:UIControlStateNormal];
    [_meituMenuButton setImageEdgeInsets:UIEdgeInsetsMake(-10, 20, 0, 0)];
    [_meituMenuButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -30, 0, 25)];
    [_meituMenuButton setBackgroundImage:[UIImage imageNamed:@"home_block_green_a"] forState:UIControlStateNormal];
    [_meituMenuButton setBackgroundImage:[UIImage imageNamed:@"home_block_green_b"] forState:UIControlStateHighlighted];
    [self.view addSubview:_meituMenuButton];
    _meituMenuButton.center = self.view.center;
    
    [_meituMenuButton addTarget:self action:@selector(meituAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)meituAction:(id)sender
{
    
    
    [self startPicker];


}

- (void)startPicker
{
    if (_picker == nil) {
        _picker = [[ZYQAssetPickerController alloc] init];
        _picker.maximumNumberOfSelection = 5;
        _picker.assetsFilter = [ALAssetsFilter allPhotos];
        _picker.showEmptyGroups=NO;
        _picker.delegate = self;
    }
    _picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    if (IOS7) {
        _picker.navigationBar.barTintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }else{
        _picker.navigationBar.tintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }
    [D_Main_Appdelegate showPreView];
    _picker.vc =self;
    [self presentViewController:_picker animated:YES completion:NULL];
    [D_Main_Appdelegate preview].delegateSelectImage = self;
    [[D_Main_Appdelegate preview] reMoveAllResource];
    
    
}


#pragma mark
#pragma mark ImageAddPreViewDelegate
- (void)startPintuAction:(ImageAddPreView *)sender
{
    if ([sender.imageassets count] >= 2) {
        MeituEditStyleViewController *meituEditVC = [[MeituEditStyleViewController alloc] init];
        meituEditVC.assets = sender.imageassets;
        [_picker pushViewController:meituEditVC animated:YES];
    }else if([sender.imageassets count] == 1){
    }else{
        UIAlertView *imageCountWarningalert = [[UIAlertView alloc] initWithTitle:nil
                                                                         message:D_LocalizedCardString(@"card_meitu_max_image_count_less_than_two")
                                                                        delegate:self
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:D_LocalizedCardString(@"card_meitu_max_image_promptDetermine"), nil];
        [imageCountWarningalert show];
        
        
    }
    
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
