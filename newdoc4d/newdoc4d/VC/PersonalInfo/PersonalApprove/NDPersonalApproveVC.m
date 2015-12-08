//
//  NDPersonalApproveVC.m
//  newdoc
//
//  Created by zzc on 15/10/20.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalApproveVC.h"
#import "NDSigningVC.h"
#import "NDBaseNavVC.h"

@interface NDPersonalApproveVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellName;
@property (strong, nonatomic) IBOutlet FormCell *cellId;
@property (strong, nonatomic) IBOutlet FormCell *cellSubroom;

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfIdCard;

@property (strong, nonatomic) IBOutlet UIView *vPickClass;

@property (weak, nonatomic) IBOutlet UIPickerView *pkSubroom;

@property (nonatomic, strong) NSMutableArray *subRooms;

@property (weak, nonatomic) IBOutlet UIButton *btnSubroom;


@end

@implementation NDPersonalApproveVC

- (NSMutableArray *)subRooms{
    if(_subRooms == nil){
        _subRooms = [NSMutableArray array];
    }
    
    return _subRooms;
}

- (NSMutableArray *)imgs{
    if(_imgs == nil){
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"实名认证";
    
    [self setupUI];
}

- (void)setupUI{
    
    WEAK_SELF;
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tfIdCard,self.tfName]];
    
    [self appendSection:@[self.cellName,self.cellId,self.cellSubroom] withHeader:nil];
    
    [self startAllSubroomAndSuccess:^(NSArray *subrooms) {
        weakself.subRooms = subrooms;
        
        if(subrooms.count == 0){
            return;
        }
        
        [weakself.pkSubroom reloadComponent:0];
    } failure:^(NSString *error_message) {
        
    }];

    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    [_collectionView registerClass:[NDPhotoGridCell class] forCellWithReuseIdentifier:@"NDPhotoGridCell"];
    [self.imgs addObject:[UIImage imageNamed:@"icon_img_plus"]];
    
    UUPhotoActionSheet *photoActionSheet = [[UUPhotoActionSheet alloc] initWithMaxSelected:5 weakSuper:self];
    self.photoActionSheet = photoActionSheet;
    
    self.photoActionSheet.delegate = self;
    [self.navigationController.view addSubview:self.photoActionSheet];
    
    
}

- (void)rightBtnClicked:(UIButton *)btn{
    WEAK_SELF;
    
    if(self.tfName.text.length == 0){
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    
    if(self.tfIdCard.text.length == 0){
        [MBProgressHUD showError:@"身份证号不能为空"];
        return;
    }
    
    if(self.tfIdCard.text.length == 0){
        [MBProgressHUD showError:@"身份证号不能为空"];
        return;
    }
    
    if(![self isIdCard:self.tfIdCard.text]){
        [MBProgressHUD showError:@"身份证号格式不正确"];
        return;
    }
    
    if(self.btnSubroom.titleLabel.text.length == 0 || [self.btnSubroom.titleLabel.text isEqualToString:@"点击选择科室"]){
        [MBProgressHUD showError:@"请选择科室"];
        return;
    }
    
//    if(self.imgs.count >0){
//        [self.imgs removeLastObject];
//    }
    
    NSMutableArray *tempArr = self.imgs;
    if(tempArr.count > 1){
        [tempArr removeLastObject];
    }

    if(self.imgs.count <= 0){
        [MBProgressHUD showError:@"请上传行医执照"];
        return;
    }
    
    [self startUploadImageWithImages:self.imgs success:^(NSArray *imgUrls) {
        [weakself startRealNameAuthenticationWithName:weakself.tfName.text andIdCard:weakself.tfIdCard.text andImgUrls:imgUrls success:^(NSObject *resultDic) {
        } failure:^(NSString *error_message) {
            
        }];
        
        NDSigningVC *vc = [NDSigningVC new];
        vc.hiddenLeft = YES;
        NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:vc];
        
        [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
    } failure:^(NSString *error_message) {
        
    }];

    
}

-(BOOL)isIdCard:(NSString *)str
{
    NSString * regex        = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.vPickClass.frame = CGRectMake(0, 0, self.view.width, 200);
    self.vPickClass.center = self.tableView.center;
    self.vPickClass.hidden = YES;
    [self.view addSubview:self.vPickClass];
}

- (IBAction)showMore:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.vPickClass.hidden = !sender.selected;
}

- (IBAction)btnPickDoneClicked:(id)sender {
    self.btnSubroom.selected = !self.btnSubroom.selected;
    
    self.vPickClass.hidden = YES;
    
    NSInteger currentSelectRow = [self.pkSubroom selectedRowInComponent:0];
    
    if(self.subRooms.count == 0){
        return;
    }
    
    [self.btnSubroom setTitle:self.subRooms[currentSelectRow] forState:UIControlStateNormal];
}



#pragma pickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    return self.room.catalogs.count;
    return self.subRooms.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NDSubroom *subroom = self.room.catalogs[row];
//    return subroom.name;
    return self.subRooms[row];
}

@end
