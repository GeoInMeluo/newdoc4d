//
//  NDPersonalReferFooterCell.h
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDQAMessage.h"

@interface NDPersonalReferFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

@property (nonatomic, strong) NDQAMessage *qaMessage;
@end
