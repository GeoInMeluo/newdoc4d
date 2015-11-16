//
//  NDQAOnlineVC.m
//  newdoc
//
//  Created by zzc on 15/10/23.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDQAOnlineVC.h"
#import "NDQAMessageCenter.h"
#import "NDChatVC.h"
@interface NDQAOnlineVC ()

@property (strong, nonatomic) IBOutlet UIView *vPickClass;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerSubroom;

@property (nonatomic, strong) NSArray *subrooms;

@end

@implementation NDQAOnlineVC

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tfAge resignFirstResponder];
    [self.tvQuestion resignFirstResponder];
}

- (NSMutableArray *)imgs{
    if(_imgs == nil){
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"在线咨询";
    
    [_collectionView registerClass:[NDPhotoGridCell class] forCellWithReuseIdentifier:@"NDPhotoGridCell"];
    [self.imgs addObject:[UIImage imageNamed:@"icon_img_plus"]];
    
    UUPhotoActionSheet *photoActionSheet = [[UUPhotoActionSheet alloc] initWithMaxSelected:5 weakSuper:self];
    self.photoActionSheet = photoActionSheet;
    
    self.photoActionSheet.delegate = self;
    [self.navigationController.view addSubview:self.photoActionSheet];
    
    self.pickerSubroom.delegate = self;
    self.pickerSubroom.dataSource = self;
    
    self.subrooms = @[@"全科",@"骨科",@"内科",@"外科"];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"icon_qa_message"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBtnClicked:(UIButton *)btn{
//    ShowVC(NDQAMessageCenter);
    ShowVC(NDChatVC);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.vPickClass removeFromSuperview];
    
    self.vPickClass.left = self.view.left;
    self.vPickClass.top = self.view.top;
    self.vPickClass.width = self.view.width;
    self.vPickClass.bottom = self.view.bottom;
    self.vPickClass.hidden = YES;
    [self.view addSubview:self.vPickClass];
}

- (IBAction)btnSubmitClicked:(id)sender {
    [MBProgressHUD showSuccess:@"问题提交成功！"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSubroomClicked:(id)sender {
    self.vPickClass.hidden = NO;
}

- (IBAction)btnConfirmPickSubroom:(id)sender {
    self.vPickClass.hidden = YES;
    [self.btnSubroom setTitle:self.subrooms[[self.pickerSubroom selectedRowInComponent:0]] forState:UIControlStateNormal];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
