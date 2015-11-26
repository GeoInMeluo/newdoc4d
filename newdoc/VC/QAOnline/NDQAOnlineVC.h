//
//  NDQAOnlineVC.h
//  newdoc
//
//  Created by zzc on 15/10/23.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
#import "NDPhotoGridCell.h"
#import "UUPhotoActionSheet.h"

@interface NDQAOnlineVC : NDBaseTableVC<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnSubroom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGender;
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UITextView *tvQuestion;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic, weak) UUPhotoActionSheet *photoActionSheet;

@property (nonatomic, strong) NSMutableArray *imgs;
@end
