//
//  NDRoomOrderLabeCell.h
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDRoomOrderLabeCell : UICollectionViewCell

@property (nonatomic, strong) NDPreserveWindow *preserveWindow;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomName;
@property (weak, nonatomic) IBOutlet UIButton *btnBond;

@end
