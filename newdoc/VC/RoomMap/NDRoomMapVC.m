//
//  NDRoomMapVC.m
//  newdoc
//
//  Created by zzc on 15/10/15.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomMapVC.h"
#import "NDBaseNavVC.h"
#import "NDRoomSelectVC.h"
#import "NDRoomAnnotationPopView.h"
#import "NDRoomSelectMoreVC.h"

@interface NDRoomMapVC ()

@property (nonatomic, weak) IBOutlet BMKMapView* mapView;
@property (nonatomic, strong) NDRoomSelectVC *selectVC;
@property (nonatomic, strong) NDRoomSelectMoreVC *selectMoreVC;
@property (weak, nonatomic) IBOutlet UIView *searchDiv;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *segmentView;
@property (nonatomic, assign) BOOL currentMap;
@property (weak, nonatomic) UIView *slider;



@end

@implementation NDRoomMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约挂号";
    
    [self setupUI];
}

- (void)setupUI{
    
    self.currentMap = YES;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"map_rightBtn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.searchDiv.layer.cornerRadius = 5;
    self.searchDiv.layer.masksToBounds = YES;
    
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentView.height - 2, self.segmentView.width * 0.4, 2)];
    slider.centerX = kScreenSize.width * 0.75;
    slider.backgroundColor = Blue;
    
    [self.segmentView addSubview:slider];
    self.slider = slider;
}

- (void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    
    _mapView.delegate = self;
    
    //     添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
    
    [_mapView selectAnnotation:annotation animated:YES];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.segmentView.hidden = self.currentMap;
    [self.view addSubview:self.segmentView];
    self.segmentView.top = self.topView.bottom;
    self.segmentView.width = self.view.width;
    
    NDRoomSelectMoreVC *selectMoreVC = [NDRoomSelectMoreVC new];
    selectMoreVC.view.width = _mapView.width;
    selectMoreVC.view.height = _mapView.height - self.segmentView.height;
    selectMoreVC.view.top = self.segmentView.bottom;
    [self.view addSubview:selectMoreVC.view];
    selectMoreVC.view.hidden = YES;
    self.selectMoreVC = selectMoreVC;
    
    
    NDRoomSelectVC *selectVC = [NDRoomSelectVC new];
    selectVC.tableView.width = _mapView.width;
    selectVC.tableView.height = _mapView.height - self.segmentView.height;
    selectVC.tableView.top = self.segmentView.bottom;
    [self.view addSubview:selectVC.tableView];
    selectVC.view.hidden = self.currentMap;
    self.selectVC = selectVC;

}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        // 设置颜色
        newAnnotation.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        newAnnotation.animatesDrop = YES;
        // 设置可拖拽
        newAnnotation.draggable = YES;
        //设置大头针图标
        newAnnotation.image = [UIImage imageNamed:@"map_ten_L"];
        //自定义显示的内容
        NDRoomAnnotationPopView *pop = [NDRoomAnnotationPopView new];
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:pop];
        pView.frame = CGRectMake(0, 0, 161, 116);
        pView.backgroundColor = [UIColor whiteColor];
        pView.layer.cornerRadius = 10;
        pView.layer.masksToBounds = YES;
        pView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        pView.layer.borderWidth = 1;
        ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
        ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;
        
        return newAnnotation;

    }
    return nil;

}

- (void)rightBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.currentMap = !self.currentMap;
    self.selectVC.tableView.hidden = self.currentMap;
    self.segmentView.hidden = self.currentMap;
    self.selectMoreVC.view.hidden = self.selectVC.tableView.hidden;
    
    if(btn.selected){
        [BMKMapView willBackGround];
    }else{
        [BMKMapView didForeGround];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    self.selectVC = nil;
}


- (IBAction)leftSegClicked:(UIButton *)sender {
    WEAK_SELF;
    
    self.selectVC.tableView.hidden = YES;
    self.selectMoreVC.view.hidden = NO;

    
    [UIView animateWithDuration:0.3 animations:^{
        weakself.slider.centerX = weakself.view.width * 0.25;
    }];
}

- (IBAction)rightSegClicked:(UIButton *)sender {
    WEAK_SELF;
    
    self.selectVC.tableView.hidden = NO;
    self.selectMoreVC.view.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakself.slider.centerX = weakself.view.width * 0.75;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
