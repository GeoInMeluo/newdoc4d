//
//  NDRoomSelectMoreVC.h
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"

@interface NDRoomSelectMoreVC : NDBaseVC
@property (nonatomic, weak) UIViewController *parentVC;
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;

@end
