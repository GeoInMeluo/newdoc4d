//
//  BkActionSheet.h
//  qiba2
//
//  Created by zzc on 13-10-16.
//  Copyright (c) 2013年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheet;
typedef void(^ActionSheetCallback)(ActionSheet * sheet,int buttonIndex);


@interface ActionSheet : UIActionSheet<UIActionSheetDelegate>

@property(nonatomic,strong) id data;
@property(nonatomic,strong) ActionSheetCallback callback;


@end
