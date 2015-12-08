//
//  NDEhr.h
//  newdoc
//
//  Created by zzc on 15/11/10.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//病历
@interface NDEhr : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *actual_date;
@property (nonatomic, copy) NSString *detail;
@end
