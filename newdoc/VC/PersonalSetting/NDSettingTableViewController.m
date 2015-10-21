//
//  NDSettingTableViewController.m
//  newdoc
//
//  Created by dajie on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDSettingTableViewController.h"

@interface NDSettingTableViewController ()
@property (strong, nonatomic) IBOutlet FormCell *cellProtocal;
@property (strong, nonatomic) IBOutlet FormCell *cellAbout;

@end

@implementation NDSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    [self initWithCells];
}

- (void)initWithCells{
    [self.cells addObjectsFromArray:@[self.cellProtocal,self.cellAbout]];
}
    
@end
