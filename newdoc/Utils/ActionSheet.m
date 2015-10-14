//
//  BkActionSheet.m
//  qiba2
//
//  Created by 焦海涛 on 13-10-16.
//  Copyright (c) 2013年 焦海涛. All rights reserved.
//

#import "ActionSheet.h"

@implementation ActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

@end
