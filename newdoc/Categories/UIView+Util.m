//
//  UIView+Util.m
//  pic
//
//  Created by xxxxxx on 13-7-13.
//  Copyright (c) 2013年 xxxxxx. All rights reserved.
//

#import "UIView+Util.h"
//#import "NSArray+Util.h"

@implementation UIView (Util)
-(CGPoint)boundsCenter
{
	return CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}



- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
-(void)setLeft:(float)aleft
{
    CGRect r = self.frame;
    r.origin.x = aleft;
    self.frame = r;
}

-(void)setRight:(float)aright
{
    self.left = aright - self.width;
}
-(void)setTop:(float)atop
{
    CGRect r = self.frame;
    r.origin.y = atop;
    self.frame = r;
}
-(void)setBottom:(float)abottom
{
    CGRect r = self.frame;
    r.origin.y = abottom-r.size.height;
    self.frame = r;
}

-(void)setHeight:(float)aheight
{
    CGRect r = self.frame;
    r.size.height = aheight;
    self.frame = r;
}
-(void)setWidth:(float)awidth
{
    CGRect r = self.frame;
    r.size.width = awidth;
    self.frame = r;
}
-(void) setWidthKeepRight:(float)awidth
{
    self.left = self.right - awidth;
    self.width = awidth;
}
-(void) setLeftKeepRight:(float)aleft
{
    self.width = self.right - aleft;
    self.left = aleft;
}
-(float)left
{
    return self.frame.origin.x;
}
-(float)right
{
    return self.frame.origin.x+self.frame.size.width;
}
-(float)top
{
    return self.frame.origin.y;
}
-(float)bottom
{
    return self.frame.origin.y+self.frame.size.height;
}
-(float)width
{
    return self.frame.size.width;
}
-(float)height
{
    return self.frame.size.height;
}
-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)asize
{
    CGRect r = self.frame;
    r.size = asize;
    self.frame = r;
}
-(void)clearSubviews
{
    NSArray * arr = [NSArray arrayWithArray:self.subviews];
    for(UIView * v in arr)
    {
        [v removeFromSuperview];
    }
}
-(void)moveToCenterInParent
{
    CGRect rp = self.superview.frame;
    CGRect r = self.bounds;
    self.frame = CGRectMake((rp.size.width-r.size.width)/2,
                            (rp.size.height-r.size.height)/2,
                            r.size.width, r.size.height);
}
typedef void(^AnimateBlockCallback)();
//+(void)animateWithDurAndBlocks:(NSArray*)durAndBlocks
//{
//    NSNumber * durobj = durAndBlocks[0];
//    float dur = 0;
//    if(durobj && durobj != (id)[NSNull null])
//        dur = durobj.floatValue;
//    
//    [UIView animateWithDuration:dur
//                     animations:^{
//                         AnimateBlockCallback ab = durAndBlocks[1];
//                         ab();
//                     } completion:^(BOOL finished) {
//                         if(durAndBlocks.count>2)
//                         {
//                             NSArray * arr = [durAndBlocks subArrayFromIndex:2];
//                             [self animateWithDurAndBlocks:arr];
//                         }
//                     }];
//}
@end
