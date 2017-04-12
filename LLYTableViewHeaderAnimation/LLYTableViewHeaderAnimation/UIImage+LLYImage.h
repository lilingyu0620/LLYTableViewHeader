//
//  UIImage+LLYImage.h
//  LLYTableViewHeaderAnimation
//
//  Created by lly on 2017/4/12.
//  Copyright © 2017年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLYImage)

- (UIImage*)cutImageWithRect:(CGRect)rect;

- (UIImage *)imageWithColor:(UIColor *)color;

@end
