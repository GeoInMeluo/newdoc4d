//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.

#import <UIKit/UIKit.h>
#import "NDQAMessage.h"

@interface NDChatVC : NDBaseVC<UITextFieldDelegate>
@property (nonatomic, strong) NDQAMessage *qaMesaage;
@end
