//
//  NDRoomAnnotationPopView.h
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDRoomAnnotationPopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet Button *btnPhoneNumber;
@property (weak, nonatomic) IBOutlet Button *btnRoomDetail;

@end
