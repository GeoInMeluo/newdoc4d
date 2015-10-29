//
//  NDRoomSelectCell.m
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomSelectCell.h"

@implementation NDRoomSelectCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomSelectCell" owner:nil options: nil][0];
    }
    return self;
}

- (void)setRoom:(NDRoom *)room{
    _room = room;
    
    self.lblRoomTitle.text = room.name;
    self.lblRoomAdress.text = room.address;
    self.lblRoomGoodat.text = room.detail;
    self.btnIsBond.selected = room.isBound;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
