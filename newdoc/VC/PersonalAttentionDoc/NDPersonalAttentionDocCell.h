//
//  NDPersonalAttentionDocCell.h
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDPersonalAttentionDocCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *tempDocDic;

@property (weak, nonatomic) IBOutlet UIButton *ivHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomName;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodat;

@end
