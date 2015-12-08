//
//  ShareVC.m
//  NewChinaHealthy
//
//  Created by zzc on 15/8/25.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import "ShareVC.h"
#import "UMSocial.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = self.shareUrl;
    
    WEAK_SELF;
    
    self.btnCover.callback = ^(Button *btn){
        [weakself.view removeFromSuperview];
        [weakself viewWillDisappear:YES];
    };
    
    self.btnCancel.callback = ^(Button *btn){
        [weakself.view removeFromSuperview];
        [weakself viewWillDisappear:YES];
    };
    
    self.btnWeibo.callback = ^(Button *btn){
        [weakself shareWithName:UMShareToSina];
    };
    
    self.btnFriendCircle.callback = ^(Button *btn){
        [weakself shareWithName:UMShareToWechatTimeline];
    };
    
    self.btnQQ.callback = ^(Button *btn){
        [weakself shareWithName:UMShareToQQ];
    };
    
    self.btnWechat.callback = ^(Button *btn){
        [weakself shareWithName:UMShareToWechatSession];
    };
    
    self.btnCopy.callback = ^(Button *btn){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.shareUrl];
    };
}

- (void)shareWithName:(NSString *)name{
    UMSocialUrlResource *url = [UMSocialUrlResource new];
    url.url = self.shareImageName;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[name] content:self.shareText image:[UIImage imageNamed:self.shareImageName] location:nil urlResource:url presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
}
@end
