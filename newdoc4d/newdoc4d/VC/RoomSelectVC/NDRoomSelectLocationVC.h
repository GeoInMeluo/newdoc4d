//
//  NDRoomSelectLocationVC.h
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"

typedef void(^CountyCellCallback)();

@interface NDRoomSelectLocationVC : NDBaseVC
@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *citys;
@property (nonatomic, strong) NSArray *countys;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *countyName;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) CountyCellCallback countyCellCallback;
@end
