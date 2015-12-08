//
//  UIImage+Util.m
//  NewChinaHealthy
//
//  Created by zzc on 15/8/17.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)
// rgb 转图片
+ (UIImage *)rgbToImage:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

+ (UIImage *)imageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
