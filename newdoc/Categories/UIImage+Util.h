//
//  UIImage+Util.h
//  NewChinaHealthy
//
//  Created by zzc on 15/8/17.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)
+ (UIImage *)rgbToImage:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithName:(NSString *)imageName;
@end
