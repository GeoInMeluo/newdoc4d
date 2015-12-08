//
//  NDReplyUserCommentVC.m
//  newdoc4d
//
//  Created by zzc on 15/12/2.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDReplyUserCommentVC.h"

@interface NDReplyUserCommentVC ()

@end

@implementation NDReplyUserCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"回复评论";
    
    self.btnReply.callback = ^(Button *btn){
        
        [weakself startReplyUserCommentWithComment:self.commentId andContent:weakself.tv.text success:^{
            [weakself.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error_message) {
            
        }];
        
        
    };
}
@end
