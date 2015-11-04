//
//  NDRoomOrderLabeCell.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomOrderLabeCell.h"

@implementation NDRoomOrderLabeCell

- (void)setPreserveWindow:(NDPreserveWindow *)preserveWindow{
    _preserveWindow = preserveWindow;

    self.lblRoomName.text = [NSString stringWithFormat:@"%@",preserveWindow.room_name];
    self.lblLocation.text = preserveWindow.room_address;
    self.btnBond.selected = preserveWindow.isBound;
    
}

- (void)awakeFromNib {
    // Initialization code
    
}

@end
