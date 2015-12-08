//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.
#import "UIImage+Help.h"

@implementation UIImage (Help)

+ (UIImage *)resizableImageWithImage:(NSString *)name
{
    // 之前普通图片
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    
    // 拉伸
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

@end
