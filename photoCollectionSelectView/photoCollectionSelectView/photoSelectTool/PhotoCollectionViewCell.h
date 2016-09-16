//
//  PhotoCollectionViewCell.h
//  photoCollectionSelectView
//
//  Created by Yanglixia on 16/9/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoCollectionViewCell;
@protocol PhotoCollectionViewCellDelegate <NSObject>

- (void)photoCollectionViewCell:(PhotoCollectionViewCell *)cell DidClickCloseButton:(UIButton *)closeBtn;

@end
@interface PhotoCollectionViewCell : UICollectionViewCell
/** 照片button */
@property (nonatomic, strong, readonly) UIButton *iconButton;
/** 删除button */
@property (nonatomic, strong, readonly) UIButton *closeButton;
/** 设置照片 */
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<PhotoCollectionViewCellDelegate> delegate;
+ (NSString *)identifier;

@end
