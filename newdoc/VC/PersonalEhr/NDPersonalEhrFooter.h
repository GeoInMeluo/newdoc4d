//
//  NDPersonalEhrFooter.h
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDPersonalEhrFooter : UIView
@property (nonatomic, strong) NDEhr *ehr;

//@property (weak, nonatomic) IBOutlet UILabel *lblRoomName;
//@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//@property (weak, nonatomic) IBOutlet UILabel *lblSubRoom;
//@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
//@property (weak, nonatomic) IBOutlet UILabel *lblFeature;
//@property (weak, nonatomic) IBOutlet UILabel *lblSuggest;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;


@end
