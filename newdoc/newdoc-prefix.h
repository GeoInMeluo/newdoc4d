//
//  newdoc-prefix.h
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#ifndef newdoc_prefix_h
#define newdoc_prefix_h

#ifdef DEBUG // 处于开发阶段
#define FLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define FLog(...)
#endif

#ifdef __OBJC__
#import "GlobalDefine.h"
#import <UIKit/UIKit.h>
#import "Button.h"
#import "UIColor+Util.h"
#import "UIView+Util.h"
#import "UIImage+Util.h"
#endif


#endif /* newdoc_prefix_h */
