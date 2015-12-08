//
//  NDPersonalRoomCell1.m
//  newdoc4d
//
//  Created by zzc on 15/11/29.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRoomCell1.h"

@implementation NDPersonalRoomCell1

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDPersonalRoomCell1" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
