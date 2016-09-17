//
//  photoSelectCollectionView.m
//  photoCollectionSelectView
//
//  Created by Yanglixia on 16/9/16.
//  Copyright © 2016年 test. All rights reserved.
//  照片选择--用于添加照片上传发布等功能

#import "photoSelectView.h"
#import "PhotoCollectionViewCell.h"

@interface photoFlowLayout : UICollectionViewFlowLayout
@end
@implementation photoFlowLayout
const NSInteger photoCellMargin = 10;//cell间距
const NSInteger photoCellMaxCol = 4;// 最大列数
- (void)prepareLayout
{
    [super prepareLayout];
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - (photoCellMaxCol + 1)*photoCellMargin)/ (photoCellMaxCol);
    CGFloat itemHeight = itemWidth;
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.minimumInteritemSpacing = photoCellMargin;
    self.minimumLineSpacing = photoCellMargin;
}
@end


@interface photoSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,PhotoCollectionViewCellDelegate>
/** 最大添加图片数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 哪个控制器弹出我 */
@property (nonatomic, weak) UIViewController *viewVc;
@end

@implementation photoSelectView
@synthesize collectionView = _collectionView;
@synthesize images = _images;

#pragma mark - lazy load
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[photoFlowLayout alloc] init]];
        _collectionView.contentInset = UIEdgeInsetsMake(photoCellMargin, photoCellMargin, photoCellMargin, photoCellMargin);
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:[PhotoCollectionViewCell identifier]];
        
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
- (NSMutableArray<UIImage *> *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame maxSelectCount:(NSInteger)maxCount withVc:(UIViewController *)vc
{
    self = [super initWithFrame:frame];
    if (self) {
        // Register cell classes
        [self addSubview:self.collectionView];
        self.maxCount = maxCount;
        self.viewVc = vc;
    }
    return self;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.images.count >= self.maxCount) {
        return self.maxCount;
    }
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCollectionViewCell identifier] forIndexPath:indexPath];
    
    // Configure the cell
    cell.delegate = self;
    cell.image = (indexPath.item < self.images.count) ? self.images[indexPath.item] : nil;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.closeButton.hidden) {
        // 如果右上角删除为隐藏，那么它就为+号添加图片
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        UIImagePickerController *pickerVc = [[UIImagePickerController alloc] init];
        pickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVc.delegate = self;
        
        [self.viewVc presentViewController:pickerVc animated:YES completion:nil];
        
    } else {
        
    }

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (!image) {
        NSLog(@"图片选择加载失败");
        return;
    }
    if (self.images.count < self.maxCount) {
        // 添加到数据中，要先绽放，不然图片过大，加到数据中，会占用很大的内存，程序运行内存超过500m会闪退
        UIImage *newImage = [self scaleImage:image width:100];
        [self.images addObject:newImage];
        // 3.刷新表格
        [self.collectionView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - PhotoCollectionViewCellDelegate
- (void)photoCollectionViewCell:(PhotoCollectionViewCell *)cell DidClickCloseButton:(UIButton *)closeBtn
{
    if (!closeBtn.hidden) { // 没隐藏，则为图片
        [self.images removeObject:cell.image];
        [self.collectionView reloadData];
    }
}

- (void)dealloc
{
    NSLog(@"图片选择器视图释放了~~~");
}

/**
 缩放图片
 @ parameter image: 需要缩放的图片
 @ parameter width: 图片缩放之后的宽度
 */
- (UIImage *)scaleImage:(UIImage *)image width:(CGFloat)width
{
    // 1.创建图片上下文
    UIGraphicsBeginImageContext(CGSizeMake(width,width));
    // 2.绘制图片
    [image drawInRect:CGRectMake(0, 0, width, width)];
    // 3.从上下文中取出图片
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
