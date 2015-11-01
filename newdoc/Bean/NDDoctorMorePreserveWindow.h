//
//  NDDoctorMorePreserveWindow.h
//  newdoc
//
//  Created by zzc on 15/10/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

//医生(预约界面)
@interface NDDoctorMorePreserveWindow : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picture_url;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *start_year;
@property (nonatomic, copy) NSString *years;
@property (nonatomic, strong) NSArray *catalog;
@property (nonatomic, copy) NSString *goodat;
@property (nonatomic, assign) BOOL isFocus;
@property (nonatomic, strong) NSArray *preserve_window;
@end
