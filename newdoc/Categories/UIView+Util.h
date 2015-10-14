//
//  UIView+Util.h
//  pic
//
//  Created by xxxxxx on 13-7-13.
//  Copyright (c) 2013年 xxxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)
-(CGPoint)boundsCenter;
@property(nonatomic) float left;
@property(nonatomic) float top;
@property(nonatomic) float right;
@property(nonatomic) float bottom;
@property(nonatomic) float height;
@property(nonatomic) float width;
@property(nonatomic) CGSize size;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

-(void) setWidthKeepRight:(float)awidth;
-(void) setLeftKeepRight:(float)aleft;
-(void)clearSubviews;
-(void)moveToCenterInParent;

+(void)animateWithDurAndBlocks:(NSArray*)durAndBlocks;
@end
