//
//  PhotoCollectionViewCell.m
//  photoCollectionSelectView
//
//  Created by Yanglixia on 16/9/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()
@end
@implementation PhotoCollectionViewCell
@synthesize iconButton = _iconButton;
@synthesize closeButton = _closeButton;
- (UIButton *)iconButton
{
    if (!_iconButton) {
        _iconButton = [[UIButton alloc] init];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
        _iconButton.userInteractionEnabled = NO;
    }
    return _iconButton;
}
- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.hidden = YES;
        _closeButton.userInteractionEnabled = YES;
        [_closeButton sizeToFit];
    }
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.iconButton];
        [self.contentView addSubview:self.closeButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconButton.frame = self.bounds;
    self.closeButton.frame = CGRectMake(self.frame.size.width - self.closeButton.frame.size.width, 0, self.closeButton.frame.size.width, self.closeButton.frame.size.height);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    if (image != nil) {
        [_iconButton setBackgroundImage:image forState:UIControlStateNormal];
        _closeButton.hidden = NO;//有图片，则显示删除按钮
    } else {
        _closeButton.hidden = YES;//无图，为+号，不显示删除
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
    }
}

+ (NSString *)identifier
{
    return NSStringFromClass([PhotoCollectionViewCell class]);
}

- (void)closeBtnClick:(UIButton *)closeBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoCollectionViewCell:DidClickCloseButton:)]) {
        [self.delegate photoCollectionViewCell:self DidClickCloseButton:self.closeButton];
    }
}

@end
