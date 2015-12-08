//
//  NDRoomUserCommentCell2.h
//  newdoc4d
//
//  Created by zzc on 15/11/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDRoomUserCommentCell2 : UITableViewCell
@property (nonatomic, strong) NDDoctorComment *docComment;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblDocCallback;

@end
