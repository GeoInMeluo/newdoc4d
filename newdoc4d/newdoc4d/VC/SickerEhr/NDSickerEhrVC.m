//
//  NDSickerEhrVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/29.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDSickerEhrVC.h"
#import "NDPersonalEhrVC.h"

@interface NDSickerEhrVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellName;
@property (strong, nonatomic) IBOutlet FormCell *cellSubroom;
@property (strong, nonatomic) IBOutlet FormCell *cellDoc;
@property (weak, nonatomic) IBOutlet UITextField *tfSickerName;
@property (weak, nonatomic) IBOutlet UITextField *tfDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubRoom;

@property (strong, nonatomic) IBOutlet UIView *vPickSubroom;
@property (weak, nonatomic) IBOutlet UIPickerView *pickSubroom;

@property (nonatomic, strong) NSArray *subrooms;
@end

@implementation NDSickerEhrVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    WEAK_SELF;
    
    self.showKeyboardViews = @[self.tfDocName, self.tfSickerName];
    
    self.title = @"患者病历";
    
    [self appendSection:@[self.cellName,self.cellSubroom,self.cellDoc] withHeader:nil];
    
    [self startAllSubroomAndSuccess:^(NSArray *subrooms) {
        weakself.subrooms = subrooms;
        
        if(subrooms.count == 0){
            return;
        }
        
        [weakself.pickSubroom reloadComponent:0];
    } failure:^(NSString *error_message) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.vPickSubroom.frame = CGRectMake(0, 0, self.view.width, 200);
    self.vPickSubroom.centerY = self.view.centerY;
    self.vPickSubroom.hidden = YES;
    [self.view addSubview:self.vPickSubroom];
}

- (IBAction)btnSubroomClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.vPickSubroom.hidden = !sender.selected;
}


- (IBAction)btnSearchClicked:(id)sender {
    if(self.tfSickerName.text.length == 0){
        ShowAlert(@"患者姓名不能为空");
        return;
    }
    
    if(self.tfDocName.text.length == 0){
        ShowAlert(@"医生姓名不能为空");
        return;
    }
    
    if(self.lblSubRoom.text.length == 0){
        ShowAlert(@"请选择就诊科室");
        return;
    }
    
    CreateVC(NDPersonalEhrVC);
    vc.name = self.tfSickerName.text;
    PushVC(vc);
}

- (IBAction)btnPickerClicked:(id)sender {
    self.vPickSubroom.hidden = YES;
    
    NSInteger currentSelectRow = [self.pickSubroom selectedRowInComponent:0];
    self.lblSubRoom.text = self.subrooms[currentSelectRow];
}

#pragma pickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.subrooms.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.subrooms[row];
}

@end
