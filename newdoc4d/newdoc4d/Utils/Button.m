//
//  BkButtonDefault.m
//  qiba2
//
//  Created by 焦海涛 on 13-8-6.
//  Copyright (c) 2013年 焦海涛. All rights reserved.
//

#import "Button.h"

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __init];
    }
    return self;
}
-(void)__init
{
	[self addTarget:self action:@selector(onSelfTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
}
-(void)awakeFromNib
{
    [self __init];
}
-(void)onSelfTouchUpInside:(id)sender
{
	if(self.callback)
		self.callback(self);
}
@end
