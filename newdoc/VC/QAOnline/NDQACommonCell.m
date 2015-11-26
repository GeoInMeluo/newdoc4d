//
//  NDQACommonCell.m
//  newdoc
//
//  Created by zzc on 15/11/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDQACommonCell.h"

@implementation NDQACommonCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDQACommonCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    // Configure the view for the selected state
}

@end
