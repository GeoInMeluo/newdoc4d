//
//  NDRoomSelectCell.h
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDRoom.h"

@interface NDRoomSelectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblRoomTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomGoodat;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomAdress;
@property (weak, nonatomic) IBOutlet Button *btnIsBond;

@property (weak, nonatomic) IBOutlet Button *btnGo2RoomDetail;

@property (nonatomic, strong) NDRoom *room;
@end
