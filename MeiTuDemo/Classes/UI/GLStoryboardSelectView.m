//
//  GLStoryboardSelectView.m
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLStoryboardSelectView.h"
@interface GLStoryboardSelectView()

@property (nonatomic, strong) UIButton          *selectedStoryboardBtn;

@end

@implementation GLStoryboardSelectView

- (id)initWithFrame:(CGRect)frame picCount:(NSInteger)picCount
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.picCount = picCount;
        [self initResource];
    }
    return self;
}



- (void)initResource
{
    
    _storyboardView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [_storyboardView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.6]];
    [self addSubview:_storyboardView];
    
    CGFloat width = 116/2.0f;
    CGFloat height = 100/2.0f;
    
    NSArray *imageNameArray = nil;
    
    switch (self.picCount) {
        case 2:
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle_storyboard1_icon",
                                @"makecards_puzzle_storyboard2_icon",
                                @"makecards_puzzle_storyboard3_icon",
                                @"makecards_puzzle_storyboard4_icon",
                                @"makecards_puzzle_storyboard5_icon",
                                @"makecards_puzzle_storyboard6_icon",nil];
            break;
        case 3:
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle3_storyboard1_icon",
                              @"makecards_puzzle3_storyboard2_icon",
                              @"makecards_puzzle3_storyboard3_icon",
                              @"makecards_puzzle3_storyboard4_icon",
                              @"makecards_puzzle3_storyboard5_icon",
                              @"makecards_puzzle3_storyboard6_icon",nil];
            break;
        case 4:
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle4_storyboard1_icon",
                              @"makecards_puzzle4_storyboard2_icon",
                              @"makecards_puzzle4_storyboard3_icon",
                              @"makecards_puzzle4_storyboard4_icon",
                              @"makecards_puzzle4_storyboard5_icon",
                              @"makecards_puzzle4_storyboard6_icon",nil];
            break;
        case 5:
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle5_storyboard1_icon",
                              @"makecards_puzzle5_storyboard2_icon",
                              @"makecards_puzzle5_storyboard3_icon",
                              @"makecards_puzzle5_storyboard4_icon",
                              @"makecards_puzzle5_storyboard5_icon",
                              @"makecards_puzzle5_storyboard6_icon",nil];
            break;
        default:
            break;
    }
    
    for (int i = 0; i < [imageNameArray count]; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width+(width-37)/2.0f, 2.5f, 37, 45)];
        [button setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(storyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i+1];
        [_storyboardView addSubview:button];
        if (i==0) {
            [button setSelected:YES];
            _selectedStoryboardBtn = button;
        }
    }
    [_storyboardView setContentSize:CGSizeMake([imageNameArray count]*width, height)];
    
}

/**
 *  边框的选择
 *
 *  @param sender
 */
- (void)storyboardAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button == _selectedStoryboardBtn) {
        return;
    }
    self.selectStyleIndex = button.tag;
    [_selectedStoryboardBtn setSelected:NO];
    _selectedStoryboardBtn = button;
    [_selectedStoryboardBtn setSelected:YES];
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectedStoryboardPicCount:styleIndex:)]) {
        [_delegateSelect didSelectedStoryboardPicCount:self.picCount styleIndex:self.selectStyleIndex];
    }
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
