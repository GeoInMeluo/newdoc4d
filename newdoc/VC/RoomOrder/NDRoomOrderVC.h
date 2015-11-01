//
//  NDRoomOrderVC.h
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"

@interface NDRoomOrderVC : NDBaseVC
@property (nonatomic, strong) NDDoctor *doc;
@property (nonatomic, strong) NDDoctorMorePreserveWindow *docMorePreserveWindow;
@property (nonatomic, copy) NSString *roomId;
@end
