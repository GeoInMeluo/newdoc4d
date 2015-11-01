//
//  NDRoomUserComment.h
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"

@interface NDRoomUserComment : NDBaseVC
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *mineCommentView;
@property (nonatomic, strong) NDDoctor *doc;
@property (nonatomic, strong) NSArray *docComments;
@end
