//
//  photoSelectView.h
//  photoCollectionSelectView
//
//  Created by Yanglixia on 16/9/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoSelectView : UIView

- (instancetype)initWithFrame:(CGRect)frame maxSelectCount:(NSInteger)maxCount;
/** collectionview */
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
/** 图片数据 */
@property (nonatomic, strong, readonly) NSMutableArray<UIImage *> *images;

@end
