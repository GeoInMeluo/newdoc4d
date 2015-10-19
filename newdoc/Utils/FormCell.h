//
//  FormCell.h
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FormCell;

typedef void(^CellCallback)(FormCell* sender,NSIndexPath * indexPath);

@interface FormCell : UITableViewCell

@property(nonatomic,copy) CellCallback callback;

@end
