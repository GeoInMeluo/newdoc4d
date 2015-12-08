//
//  NDPersonalGoodatVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalGoodatVC.h"

@interface NDPersonalGoodatVC ()

@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet Button *btnSubmit;


@end

@implementation NDPersonalGoodatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    WEAK_SELF;
    
    self.title = @"擅长";
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tv]];
    
    self.tv.text = [NDCoreSession coreSession].user.goodat;

    self.btnSubmit.callback = ^(Button *btn){
        NDUser *user = [NDCoreSession coreSession].user;
        
        user.goodat = self.tv.text;
        
        self.goodatCallBack(self.tv.text);
        
        [self.navigationController popViewControllerAnimated:YES];
    };
}

@end
