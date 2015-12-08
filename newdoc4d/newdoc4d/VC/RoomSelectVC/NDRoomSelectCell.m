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
    
    self.btnIsBond.hidden = NO;
    self.btnIsBond.layer.cornerRadius = 5;
    self.btnIsBond.layer.masksToBounds = YES;
    
    if(room.signed_status == 0){
        //未签约
        [self.btnIsBond setTitle:@"未签约" forState:UIControlStateNormal];
        [self.btnIsBond setBackgroundColor:Blue];
        self.btnIsBond.enabled = YES;
    }
    if(room.signed_status == 1){
        //审核中
        [self.btnIsBond setTitle:@"审核中" forState:UIControlStateNormal];
        [self.btnIsBond setBackgroundColor:[UIColor lightGrayColor]];
        self.btnIsBond.enabled = NO;
    }
    if(room.signed_status == 2){
        //已签约
        [self.btnIsBond setTitle:@"已签约" forState:UIControlStateNormal];
        [self.btnIsBond setBackgroundColor:[UIColor lightGrayColor]];
        self.btnIsBond.enabled = NO;
    }

}

- (void)awakeFromNib {
    
    self.btnGo2RoomDetail.layer.cornerRadius = 5;
    self.btnGo2RoomDetail.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
