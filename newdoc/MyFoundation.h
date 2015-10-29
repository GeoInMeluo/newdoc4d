//
//  MyFoundation.h
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void ShowAlert(NSString * text);

NSString * SafeString(NSString * s);

NSValue * SafeValue(NSValue * value);

NSNumber * SafeNumber(NSNumber * n);
