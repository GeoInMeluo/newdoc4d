//
//  NDRoomDetailVC.h
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
#import "NDRoom.h"

@interface NDRoomDetailVC : NDBaseVC<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NDRoom *room;
@property (nonatomic, copy) NSString *roomId;

@property (weak, nonatomic) IBOutlet UILabel *lblRoomName;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomGoodat;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomAddress;
@end
