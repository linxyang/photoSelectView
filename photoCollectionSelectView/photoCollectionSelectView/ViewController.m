//
//  ViewController.m
//  photoCollectionSelectView
//
//  Created by Yanglixia on 16/9/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"
#import "photoSelectView.h"

@interface ViewController ()
/** 照片选择控制器 */
@property (nonatomic, strong) photoSelectView  *photoSelectVc;
@end

@implementation ViewController
- (photoSelectView *)photoSelectVc
{
    if (!_photoSelectVc) {
        _photoSelectVc = [[photoSelectView alloc] initWithFrame:self.view.bounds maxSelectCount:4  withVc:self];
    }
    return _photoSelectVc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.photoSelectVc];

    self.photoSelectVc.frame = CGRectMake(0, 40, 375, 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *images = self.photoSelectVc.images;
    
    NSLog(@"%@",images);
}

@end
