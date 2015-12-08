//
//  NDBaseTableVC.h
//  newdoc
//
//  Created by zzc on 15/10/13.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormCell.h"
#import "FormSection.h"

@interface NDBaseTableVC : UITableViewController

@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, strong) NSMutableArray *showKeyboardViews;

@property (nonatomic, strong) UIView *tempSectionHeader;

@property (nonatomic, assign) BOOL hiddenLeft;

@property(nonatomic,retain) IBOutlet UIView * defaultHeader;
@property(nonatomic,retain) IBOutlet UIView * defaultFooter;

//@property (nonatomic, strong)  NSMutableArray *cells;
@property (nonatomic, strong)  NSMutableArray *sections;

-(FormSection*)appendSection:(NSArray*)cells withHeader:(UIView*)headerView;
-(FormSection*)appendSection:(NSArray*)cells withHeader:(UIView*)headerView andFooter:(UIView*)footerView;

- (void)pop;

- (void)showShareWithText:(NSString *)text andImg:(NSString *)img andUrl:(NSString *)urlString;

- (void)hiddenShare;
@end
