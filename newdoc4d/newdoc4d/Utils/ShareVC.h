//
//  ShareVC.h
//  NewChinaHealthy
//
//  Created by zzc on 15/8/25.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareVC : UIViewController
@property (weak, nonatomic) IBOutlet Button *btnCancel;
@property (weak, nonatomic) IBOutlet Button *btnWeibo;
@property (weak, nonatomic) IBOutlet Button *btnQQ;
@property (weak, nonatomic) IBOutlet Button *btnFriendCircle;
@property (weak, nonatomic) IBOutlet Button *btnWechat;
@property (weak, nonatomic) IBOutlet Button *btnCover;
@property (weak, nonatomic) IBOutlet Button *btnCopy;

@property (nonatomic, copy) NSString *shareText;
@property (nonatomic, copy) NSString *shareImageName;
@property (nonatomic, copy) NSString *shareUrl;

@end
