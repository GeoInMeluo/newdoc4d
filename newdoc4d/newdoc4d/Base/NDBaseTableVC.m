//
//  NDBaseTableVC.m
//  newdoc
//
//  Created by zzc on 15/10/13.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"
#import "NDBaseNavVC.h"
#import "ShareVC.h"

@interface NDBaseTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UIButton *doneButton;
@property (nonatomic, strong) ShareVC *shareVC;
@end

@implementation NDBaseTableVC

- (instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSMutableArray *)showKeyboardViews{
    if(_showKeyboardViews == nil){
        _showKeyboardViews = [NSMutableArray array];
    }
    
    return _showKeyboardViews;
}

- (UIView *)tempSectionHeader{
    if(_tempSectionHeader == nil){
        _tempSectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 8)];
        _tempSectionHeader.backgroundColor = LightGray;
    }
    return _tempSectionHeader;
}

- (NSMutableArray *)sections{
    if(_sections == nil){
        _sections = [NSMutableArray array];
    }
    return _sections;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (doneButtonshow:) name: UIKeyboardDidShowNotification object:nil];
    
    if(self.sections.count == 0){
        [self appendSection:@[] withHeader:nil];
    }

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:Blue] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.tableView.tableHeaderView = self.defaultHeader;
    self.tableView.tableFooterView = self.defaultFooter;
    
    self.tableView.tableHeaderView.height = self.defaultHeader.height;
    self.tableView.tableFooterView.height = self.defaultFooter.height;
    
    self.tableView.height -= 44;
    
    FLog(@"%zd", self.parentViewController.navigationController.viewControllers.count);
    
    if (!self.hiddenLeft) {
        UIButton *leftNavBtn = [[UIButton alloc] init];
        [leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"back"]
                    forState:UIControlStateHighlighted];
        [leftNavBtn setTitle:@"返回" forState:UIControlStateNormal];
        [leftNavBtn setTitle:@"返回" forState:UIControlStateHighlighted];
        [leftNavBtn sizeToFit];
        [leftNavBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavBtn];
    }
}

- (void)pop{
    if(self.isPresent){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (FormSection *)appendSection:(NSArray *)cells withHeader:(UIView *)headerView{
    FormSection * section = [FormSection new];
    section.headerView = headerView;
//    section.cells = [NSMutableArray array];
//    for(UIView * cell in cells)
//    {
//        if([cell isKindOfClass:[FormCell class]])
//        {
//            FormCell * bc = (FormCell *)cell;
//            UIView * v = [bc.contentView subviews][0];
//            if(bc.accessoryType == UITableViewCellAccessoryNone)
//                v.width = [UIScreen mainScreen].bounds.size.width;
//            else
//                v.width = [UIScreen mainScreen].bounds.size.width - 30;
//            v.height = cell.height;
//            [v setNeedsLayout];
//        }
//    }
    
    section.cells = [NSMutableArray array];
    for(UITableViewCell * c in cells)
    {
        if(! c.hidden)
            [section.cells addObject:c];
    }
    [self.sections addObject:section];
    return section;
}

- (FormSection *)appendSection:(NSArray *)cells withHeader:(UIView *)headerView andFooter:(UIView *)footerView{
    FormSection * section = [FormSection new];
    section.headerView = headerView;
    section.footerView = footerView;
    section.cells = [NSMutableArray array];
    for(UITableViewCell * c in cells)
    {
        if(! c.hidden)
            [section.cells addObject:c];
    }
    [self.sections addObject:section];
    return section;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.sections.count == 0){
        return;
    }
    
    FormSection *formSection = self.sections[indexPath.section];
    
    UITableViewCell *cell = formSection.cells[indexPath.row];
    
    if([cell isKindOfClass:[FormCell class]]){
        FormCell *formCell = (FormCell *)cell;
        
        if(formCell.callback){
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            
            formCell.callback(formCell, indexPath);
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FormSection *formSection = self.sections[section];
    
    if(formSection == nil){
        return 0;
    }
    return formSection.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FormSection *formSection = self.sections[indexPath.section];
    
    if(formSection == nil){
        return nil;
    }

    return formSection.cells[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.sections.count == 0){
        return 0;
    }
    
    FormSection *formSection = self.sections[indexPath.section];
    
    if(formSection == nil || formSection.cells.count == 0){
        return 0;
    }
    
    return [formSection.cells[indexPath.row] height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section < self.sections.count ){
        FormSection *formSection = self.sections[section];
        
        if(formSection.headerView != nil){
            return formSection.headerView;
        }
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.001, 0.001)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section < self.sections.count ){
        FormSection *formSection = self.sections[section];
        
        if(formSection.headerView != nil){
            return formSection.footerView;
        }
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.001, 0.001)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section < self.sections.count ){
        FormSection *formSection = self.sections[section];
        
        if(formSection.headerView != nil){
            return formSection.headerView.height;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section < self.sections.count ){
        FormSection *formSection = self.sections[section];
        
        if(formSection.footerView != nil){
            return formSection.footerView.height;
        }
    }
    
    
    
    return 0;
}

-(void) doneButtonshow: (NSNotification *)notification {
    if(self.doneButton){
        return;
    }
    
    UIButton *doneButton = [UIButton buttonWithType: UIButtonTypeCustom];
    _doneButton = doneButton;
    _doneButton.frame = [UIScreen mainScreen].bounds;
//    [_doneButton setTitle:@"完成编辑" forState: UIControlStateNormal];
    [_doneButton addTarget: self action:@selector(hideKeyboard) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:_doneButton];
}

-(void) hideKeyboard {
    [_doneButton removeFromSuperview];
    
    for(UIView *view in self.showKeyboardViews){
        [view resignFirstResponder];
    }
    
}

- (void)showShareWithText:(NSString *)text andImg:(NSString *)img andUrl:(NSString *)urlString{
    [self hiddenShare];
    
    ShareVC *shareVC = [ShareVC new];
    _shareVC = shareVC;
    shareVC.shareText = text;
    shareVC.shareImageName = img;
    shareVC.shareUrl = urlString;
    
    shareVC.view.frame = self.view.bounds;
    //    shareVC.view.userInteractionEnabled = NO;
    [self.view addSubview:shareVC.view];
}

- (void)hiddenShare{
    
    if(_shareVC){
        [_shareVC.view removeFromSuperview];
        [_shareVC viewDidDisappear:YES];
        _shareVC = nil;
    }
}

@end
