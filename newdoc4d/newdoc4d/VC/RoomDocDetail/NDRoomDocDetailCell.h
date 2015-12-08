//
//  NDRoomDocDetailCell.h
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDRoomDocDetailCell : UITableViewCell
@property (weak, nonatomic) UILabel *lblTitle;
@property (weak, nonatomic) UILabel *lblDetail;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, weak) UIView *seprator;
@end
