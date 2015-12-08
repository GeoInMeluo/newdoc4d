//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.
#import <Foundation/Foundation.h>

@interface NSString (Help)
+ (CGSize)sizeWith:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
@end
