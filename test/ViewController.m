//
//  ViewController.m
//  test
//
//  Created by dong on 2017/11/10.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *yuanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
////    拉升变形镜滤镜
//    // 创造输入源
//    GPUImagePicture * gpuPicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"dong"]];
//    //创建滤镜
//    GPUImageStretchDistortionFilter *strechDistortionFilter = [GPUImageStretchDistortionFilter new];
//    //为滤镜赋值
//    strechDistortionFilter.center = CGPointMake(0.2, 0.2);
//    //将输入源和滤镜绑定
//    [gpuPicture addTarget:strechDistortionFilter];
//    //为原图附上滤镜效果
//    [gpuPicture processImage];
//    //滤镜收到原图产生的一个frame，并将它作为自己的当前图像缓存
//    [strechDistortionFilter useNextFrameForImageCapture];
//    //通过滤镜，获取当前的图像
//    UIImage *image = [strechDistortionFilter imageFromCurrentFramebuffer];
    
    //复合滤镜
    //获取原图
    GPUImagePicture *gpupicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"dong"]];
    GPUImageView *gpuimageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 400, 320, 320)];
    [self.view addSubview:gpuimageView];
    GPUImageToonFilter *toonFilter = [GPUImageToonFilter new];
    toonFilter.threshold = 0.1;
    GPUImageStretchDistortionFilter *stretchDistortionFilter = [GPUImageStretchDistortionFilter new];
    stretchDistortionFilter.center = CGPointMake(0.5, 0.5);
    NSArray *filters = @[toonFilter, stretchDistortionFilter];
    GPUImageFilterPipeline *pipLine = [[GPUImageFilterPipeline alloc] initWithOrderedFilters:filters input:gpupicture output:gpuimageView];
    [gpupicture processImage];
    [stretchDistortionFilter useNextFrameForImageCapture];
    UIImage *image = [pipLine currentFilteredFrame];

    self.yuanImageView.image = [UIImage imageNamed:@"dong"];
    self.currentImageView.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
