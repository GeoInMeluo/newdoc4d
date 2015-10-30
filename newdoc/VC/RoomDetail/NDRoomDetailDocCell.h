//
//  NDRoomDetailDocCell.h
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDDoctor.h"

@interface NDRoomDetailDocCell : UITableViewCell
@property (nonatomic, strong) NDDoctor *doctor;
@property (weak, nonatomic) IBOutlet UIButton *btnHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocDetail;
@property (weak, nonatomic) IBOutlet Button *btnAttention;
@property (weak, nonatomic) IBOutlet UILabel *lblSubroom;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodat;
@property (weak, nonatomic) IBOutlet UILabel *lblCanOrder;
@property (weak, nonatomic) IBOutlet Button *btnGo2Order;

@end
