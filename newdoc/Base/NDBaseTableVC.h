//
//  NDBaseTableVC.h
//  newdoc
//
//  Created by zzc on 15/10/13.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormCell.h"

@interface NDBaseTableVC : UITableViewController
@property(nonatomic,retain) IBOutlet UIView * defaultHeader;
@property(nonatomic,retain) IBOutlet UIView * defaultFooter;

@property (nonatomic, strong)  NSMutableArray *cells;
@end
