//
//  NDRoomSelectVC.h
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"

@interface NDRoomSelectVC : NDBaseTableVC
@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) NSArray *rooms;
@end
