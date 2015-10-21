//
//  NDPersonalEhrFooter.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalEhrFooter.h"

@implementation NDPersonalEhrFooter

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDPersonalEhrFooter" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib {
//    self.width = [UIScreen mainScreen].bounds.size.width;
}

@end
