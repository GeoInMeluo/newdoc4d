//
//  NDPreserveWindow.h
//  newdoc
//
//  Created by zzc on 15/10/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//预约窗口
@interface NDPreserveWindow : NSObject
@property (nonatomic, copy) NSString *ID;
//诊室的id
@property (nonatomic, copy) NSString *roomid;
//诊室名
@property (nonatomic, copy) NSString *room_name;
//诊室地址
@property (nonatomic, copy) NSString *room_address;
//诊室地址
@property (nonatomic, assign) BOOL isBound;
//在这个诊室下的预约窗口
@property (nonatomic, strong) NSArray *slots;
@end
