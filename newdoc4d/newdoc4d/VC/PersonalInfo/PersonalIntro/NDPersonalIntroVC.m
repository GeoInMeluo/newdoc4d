//
//  NDPersonalIntroVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalIntroVC.h"

@interface NDPersonalIntroVC ()
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet Button *btnSave;

@end

@implementation NDPersonalIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"简介";
    
    self.tv.text = [NDCoreSession coreSession].user.detail;
    
    self.btnSave.callback = ^(Button *btn){
        [NDCoreSession coreSession].user.detail = weakself.tv.text;
        
        weakself.callBack(weakself.tv.text);
        
        [weakself.navigationController popViewControllerAnimated:YES];
    };
}

@end
