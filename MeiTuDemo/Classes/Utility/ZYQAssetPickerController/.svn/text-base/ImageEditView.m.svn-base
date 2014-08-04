//
//  ImageEditView.m
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "ImageEditView.h"

@implementation ImageEditView

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
    self.backgroundColor = [UIColor clearColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,
                                                               10,
                                                               self.frame.size.width - 10,
                                                               self.frame.size.height - 10)];
    _imageView.contentMode=UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds=YES;
    _imageView.layer.borderWidth = 2.0f;
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_imageView];
    

    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               20,
                                                               20)];
    [_deleteButton.layer setCornerRadius:12.5f];
    [_deleteButton setImage:[ImageUtility imageWithStyleName:@"makecards_picture_turnoff_icon"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self
                      action:@selector(deleteButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_deleteButton];
    
}

- (void)setImageAsset:(ALAsset *)asset index:(NSInteger)index
{
    _asset = asset;
    _index = index;
    
    UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_imageView setImage:tempImg];
    });
}

- (void)deleteButtonAction:(id)sender
{
    if(_deleteEdit && [_deleteEdit respondsToSelector:@selector(responseToDelete:)])
    {
        [_deleteEdit responseToDelete:self];
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
