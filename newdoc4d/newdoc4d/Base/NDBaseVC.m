//
//  NCBaseVC.m
//  newdoc
//
//  Created by zzc on 15/10/3.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
#import "NDBaseNavVC.h"
#import "ShareVC.h"

@interface NDBaseVC ()
@property (nonatomic, weak) UIButton *doneButton;
@property (nonatomic, strong) ShareVC *shareVC;
@end

@implementation NDBaseVC

- (NSMutableArray *)showKeyboardViews{
    if(_showKeyboardViews == nil){
        _showKeyboardViews = [NSMutableArray array];
    }
    
    return _showKeyboardViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:Blue] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (doneButtonshow:) name: UIKeyboardDidShowNotification object:nil];
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if([self rightView]){
        self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self rightView]];
    }
    
    self.view.height -= 44;
    
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

- (UIButton *)rightView{
    return nil;
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
