//
//  NDReplyUserCommentVC.h
//  newdoc4d
//
//  Created by zzc on 15/12/2.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"

@interface NDReplyUserCommentVC : NDBaseVC
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet Button *btnReply;
@property (nonatomic, copy) NSString *commentId;
@end
