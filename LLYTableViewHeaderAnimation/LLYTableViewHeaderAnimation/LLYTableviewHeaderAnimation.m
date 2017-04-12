//
//  LLYTableviewHeaderAnimation.m
//  LLYTableViewHeaderAnimation
//
//  Created by lly on 2017/4/12.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYTableviewHeaderAnimation.h"
#import <Accelerate/Accelerate.h>
#import "UIImage+LLYImage.h"

@interface LLYTableviewHeaderAnimation ()
@property (weak, nonatomic) IBOutlet UITableView *mTableview;
@property (nonatomic,strong) UIImageView *mImageView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *testView;
@property (nonatomic,assign) BOOL hasNacImage;
@property (nonatomic,strong) UIImageView *navImageView;

@end

@implementation LLYTableviewHeaderAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"HeaderView动画";
    
    self.hasNacImage = NO;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    
    self.testView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 264)];
    self.testView.backgroundColor = [UIColor greenColor];
    
    self.testView.layer.contents = (__bridge id)[UIImage imageNamed:@"headerImage"].CGImage;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.headerView.backgroundColor = [UIColor blueColor];
    self.mTableview.tableHeaderView = self.headerView;
    [self.mTableview addSubview:_testView];
    
    [self.mTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor redColor];
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.frame.size.width; // 图片宽度
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"===%f===",offsetY);
    if (offsetY < -64) {
        CGFloat totalOffset = 264 + (ABS(offsetY) - 64);
        CGFloat f = totalOffset / 264;
        self.testView.frame =  CGRectMake(- (width * f - width) / 2, offsetY, width * f, totalOffset);
    }
    
    CGFloat offsetXP = -64 + 132;
    if (offsetY > offsetXP && offsetY <= 200) {
        
        CGFloat x = (offsetY - offsetXP)/132;
        UIImage *effImage = [self boxblurImage:[UIImage imageNamed:@"headerImage"] withBlurNumber:x];
        self.testView.layer.contents = (__bridge id)effImage.CGImage;
        
        CGFloat imageW = effImage.size.width;
        CGFloat imageH = effImage.size.height;
        CGFloat xxxxY = 200.000/264.000*imageH;
        CGFloat xxxxW = imageW;
        CGFloat xxxxH = 64.000/264.000*imageH;
        
        if (offsetY >= 136 && !self.hasNacImage) {
            
            UIImage *navImage = [effImage cutImageWithRect:CGRectMake(0, xxxxY, xxxxW, xxxxH)];
            navImage = [navImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
            [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
            self.hasNacImage = YES;
            
        }
        else if(offsetY < 136 && self.hasNacImage){
            
            self.hasNacImage = NO;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        }
    }
    else{
    
        UIImage *effImage = [self boxblurImage:[UIImage imageNamed:@"headerImage"] withBlurNumber:0];
        self.testView.layer.contents = (__bridge id)effImage.CGImage;
    }
    
    
}


-(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
