//
//  NDBaseTableVC.m
//  newdoc
//
//  Created by zzc on 15/10/13.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"

@interface NDBaseTableVC ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation NDBaseTableVC

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
    
    if(self.sections.count == 0){
        [self appendSection:@[] withHeader:nil];
    }

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#0099ff"]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.tableView.tableHeaderView = self.defaultHeader;
    self.tableView.tableFooterView = self.defaultFooter;
    
    self.tableView.height -= 44;
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
    FormSection *formSection = self.sections[indexPath.section];
    
    if(formSection == nil){
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
