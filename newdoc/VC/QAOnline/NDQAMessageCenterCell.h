//
//  NDQAMessageCenterCell.h
//  newdoc
//
//  Created by zzc on 15/11/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDQAMessage.h"

@interface NDQAMessageCenterCell : UITableViewCell
@property (nonatomic, strong) NDQAMessage *message;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
