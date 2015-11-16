//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.

#import <UIKit/UIKit.h>

@class NDMessageFrame;

@interface NDMessageCell : UITableViewCell

/**
 *  包含进来一个带有frame模型
 */
@property (nonatomic, strong) NDMessageFrame *messageframe;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
