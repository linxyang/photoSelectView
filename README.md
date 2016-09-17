# photoSelectView
一个用于发布状态界面，添加多图的collectionView选择器。

可以设置最大选择图片数量

* 使用方法示例

```

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
        _photoSelectVc = [[photoSelectView alloc] initWithFrame:self.view.bounds maxSelectCount:4  withVc:self];// 可以设置最大选择数
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

// 在这里拿到选择后的照片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *images = self.photoSelectVc.images;
    
    NSLog(@"%@",images);
}

@end

```
![image](https://github.com/linxyang/photoSelectView/blob/master/1.gif)