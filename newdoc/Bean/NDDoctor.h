//
//  NDDoctor.h
//  newdoc
//
//  Created by zzc on 15/10/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDPreserveWindow.h"
//医生
@interface NDDoctor : NSObject
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
//@property (nonatomic, strong) NDPreserveWindow *preserve_window;
@property (nonatomic, strong) NSArray *slots;
@end
