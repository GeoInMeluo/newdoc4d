//
//  NDDocSelfVC.m
//  newdoc
//
//  Created by zzc on 15/11/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDocSelfVC.h"

@interface NDDocSelfVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ivBackground;
@property (strong, nonatomic) IBOutlet UIView *vBack;
@property (strong, nonatomic) IBOutlet UIView *vFront;

@property (weak, nonatomic) IBOutlet UIView *vTop;
@property (strong, nonatomic) IBOutlet UIView *vDetail;
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;

@property (nonatomic, weak) UISwitch *swithFB;

@property (nonatomic, weak) UIView *vContent;

@property (nonatomic, strong) NSMutableArray *fBottons;
@property (nonatomic, strong) NSMutableArray *BBottons;
@end

@implementation NDDocSelfVC

- (NSMutableArray *)fBottons{
    if(_fBottons == nil){
        _fBottons = [NSMutableArray array];
    }
    return _fBottons;
}

- (NSMutableArray *)BBottons{
    if(_BBottons == nil){
        _BBottons = [NSMutableArray array];
    }
    return _BBottons;
}

- (void)switchBack:(UISwitch *)sender {
    
    if(!sender.on){
        self.ivBackground.image = [UIImage imageWithName:@"正面"];
        
        
        for(Button *btn in self.fBottons){
            
            @autoreleasepool {
                btn.hidden = NO;
            }
        }
        
        for(Button *btn in self.BBottons){
            @autoreleasepool {
                btn.hidden = YES;
            }
        }
        
        
    }else{
        self.ivBackground.image = [UIImage imageWithName:@"背面"];
        
        for(Button *btn in self.fBottons){
            @autoreleasepool {
                btn.hidden = YES;
            }
        }
        
        for(Button *btn in self.BBottons){
            @autoreleasepool {
                btn.hidden = NO;
            }
        }
    }
}

- (IBAction)change2List:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        self.swithFB.hidden = NO;
        self.vDetail.hidden = YES;
    }else{
        self.swithFB.hidden = YES;
        self.vDetail.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"新医自诊";
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    WEAK_SELF;
    
    CGFloat bili = 0.52;
    
    CGFloat bgImgH = kScreenSize.height - 45 - 64 - 49;
    CGFloat bgImgW = bgImgH * bili;
    
    UIView *vContent = [[UIView alloc] initWithFrame:CGRectMake((kScreenSize.width - bgImgW) * 0.5, 45, bgImgW, bgImgH)];
    self.vContent = vContent;
    
    UIImageView *ivBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, vContent.width, vContent.height)];
    ivBackground.image = [UIImage imageNamed:@"正面"];
    self.ivBackground = ivBackground;
    
    [vContent addSubview:ivBackground];
    
    [self.view addSubview:vContent];

    Button *btnLeftArm = [[Button alloc] initWithFrame:CGRectMake(0, vContent.height * 0.22, vContent.width * 0.28, vContent.height * 0.36)];
    [self.fBottons addObject:btnLeftArm];
    btnLeftArm.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"上肢"];
    };
    [vContent addSubview: btnLeftArm];
    
    Button *btnRightArm = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.71, vContent.height * 0.22, vContent.width * 0.28, vContent.height * 0.36)];
    [self.fBottons addObject:btnRightArm];
    btnRightArm.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"上肢"];
    };
    [vContent addSubview: btnRightArm];
    
    Button *btnHead = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.393, vContent.height * 0.014, vContent.width * 0.217, vContent.height * 0.178)];
    [self.fBottons addObject:btnHead];
    btnHead.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"头颈部"];
    };
    [vContent addSubview: btnHead];
    
    Button *btnChest = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.307, vContent.height * 0.211, vContent.width * 0.39, vContent.height * 0.124)];
    [self.fBottons addObject:btnChest];
    btnChest.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"胸腔"];
    };
    [vContent addSubview: btnChest];
    
    Button *btnStomatch = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.358, vContent.height * 0.33, vContent.width * 0.322, vContent.height * 0.134)];
    [self.fBottons addObject:btnStomatch];
    btnStomatch.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"腹部"];
    };
    [vContent addSubview: btnStomatch];
    
    Button *btnKudang = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.336, vContent.height * 0.463, vContent.width * 0.364, vContent.height * 0.1)];
    [self.fBottons addObject:btnKudang];
    btnKudang.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"盆腔"];
    };
    [vContent addSubview: btnKudang];
    
    Button *btnLeftLeg = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.281, vContent.height * 0.568, vContent.width * 0.158, vContent.height * 0.428)];
    [self.fBottons addObject:btnLeftArm];
    btnLeftLeg.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"下肢"];
    };
    [vContent addSubview: btnLeftLeg];
    
    Button *btnRightLeg = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.552, vContent.height * 0.568, vContent.width * 0.158, vContent.height * 0.428)];
    [self.fBottons addObject:btnRightLeg];
    btnRightLeg.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"下肢"];
    };
    [vContent addSubview: btnRightLeg];
    
    Button *btnBack = [[Button alloc] initWithFrame:CGRectMake(vContent.width * 0.3, vContent.height * 0.196, vContent.width * 0.451, vContent.height * 0.28)];
    [self.BBottons addObject:btnBack];
    btnBack.callback = ^(Button *btn){
        weakself.ivBackground.image = [UIImage imageNamed:@"后背"];
    };
    [vContent addSubview: btnBack];
    
    self.vDetail.frame = self.vContent.frame;
    self.vDetail.left = 0;
    self.vDetail.width = kScreenSize.width;
    self.vDetail.hidden = YES;
    [self.view addSubview:self.vDetail];
    
    UISwitch *switchFB = [[UISwitch alloc] init];
    self.swithFB = switchFB;
    [switchFB addTarget:self action:@selector(switchBack:) forControlEvents:UIControlEventValueChanged];
    switchFB.left = 20;
    switchFB.top  = self.vTop.bottom + 10;
    [self.view addSubview:switchFB];
    
    for(Button *btn in self.BBottons){
        @autoreleasepool {
            btn.hidden = YES;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if(tableView == self.leftTable){
    
    }else{
        cell.backgroundColor = LightGray;
    }
    
    return cell;
    
}

@end