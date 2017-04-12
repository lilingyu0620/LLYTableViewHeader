//
//  UIImage+LLYImage.m
//  LLYTableViewHeaderAnimation
//
//  Created by lly on 2017/4/12.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "UIImage+LLYImage.h"

@implementation UIImage (LLYImage)

- (UIImage*)cutImageWithRect:(CGRect)rect
{
    NSLog(@"image width = %f,height = %f",self.size.width,self.size.height);
    CGImageRef cgimg = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    
    return newImg;
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
