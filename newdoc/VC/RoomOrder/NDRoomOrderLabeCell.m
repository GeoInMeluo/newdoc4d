//
//  NDRoomOrderLabeCell.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomOrderLabeCell.h"

@implementation NDRoomOrderLabeCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomOrderLabeCell" owner:nil options:nil][0];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
