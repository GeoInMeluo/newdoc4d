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
#import "NDRoomSelectLocationVC.h"

@interface NDRoomMapVC ()

@property (nonatomic, weak) IBOutlet BMKMapView* mapView;
@property (nonatomic, strong) NDRoomSelectVC *selectVC;
@property (nonatomic, strong) NDRoomSelectMoreVC *selectMoreVC;
@property (nonatomic, strong) NDRoomSelectLocationVC *selectLocationVC;
@property (weak, nonatomic) IBOutlet UIView *searchDiv;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (nonatomic, assign) BOOL currentMap;
@property (weak, nonatomic) UIView *slider;
@property (nonatomic, strong) NSMutableArray *annotations;

@property (weak, nonatomic) IBOutlet UITextField *searchFiled;


@end

@implementation NDRoomMapVC

- (NSMutableArray *)annotations{
    if(_annotations == nil){
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

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
    
    self.segmentView.hidden = self.currentMap;
    [self.view addSubview:self.segmentView];
    [self.segmentView addSubview:slider];
    self.slider = slider;
}

- (void)viewWillAppear:(BOOL)animated{
//    [self.mapView viewWillAppear];
//    
//    self.mapView.delegate = self;
//    
//    //     添加一个PointAnnotation
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    annotation.coordinate = coor;
//    annotation.title = @"这里是北京";
//    [self.mapView addAnnotation:annotation];
//    [self.annotations addObject:annotation];
//    
////    [self.mapView selectAnnotation:annotation animated:YES];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.segmentView.top = self.topView.bottom;
    self.segmentView.width = self.view.width;
    
    NDRoomSelectMoreVC *selectMoreVC = [NDRoomSelectMoreVC new];
    selectMoreVC.view.width = _mapView.width;
    selectMoreVC.view.height = _mapView.height - self.segmentView.height;
    selectMoreVC.view.top = self.segmentView.bottom;
    [self.view addSubview:selectMoreVC.view];
    selectMoreVC.view.hidden = YES;
    selectMoreVC.parentVC = self;
    self.selectMoreVC = selectMoreVC;
    
    
    NDRoomSelectVC *selectVC = [NDRoomSelectVC new];
    selectVC.tableView.width = _mapView.width;
    selectVC.tableView.height = _mapView.height - self.segmentView.height;
    selectVC.tableView.top = self.segmentView.bottom;
    [self.view addSubview:selectVC.tableView];
    selectVC.view.hidden = self.currentMap;
    selectVC.parentVC = self;
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

//百度定位获取经纬度信息
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"!latitude!!!  %f",userLocation.location.coordinate.latitude);//获取经度
    NSLog(@"!longtitude!!!  %f",userLocation.location.coordinate.longitude);//获取纬度
    CLLocationDegrees localLatitude=userLocation.location.coordinate.latitude;//把获取的地理信息记录下来
    CLLocationDegrees localLongitude=userLocation.location.coordinate.longitude;
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        for (CLPlacemark *placemark in place) {
            NSString * cityStr=placemark.thoroughfare;
            NSString * cityName=placemark.locality;
            NSLog(@"city %@",cityStr);//获取街道地址
            NSLog(@"cityName %@",cityName);//获取城市名
            break;
        }
    };
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
}

- (void)rightBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.currentMap = !self.currentMap;
    self.selectVC.tableView.hidden = self.currentMap;
    self.segmentView.hidden = self.currentMap;
    self.selectMoreVC.view.hidden = self.selectVC.tableView.hidden;
    [self.selectLocationVC.view removeFromSuperview];
    self.selectLocationVC = nil;
    [self.searchFiled resignFirstResponder];
    
    if(btn.selected){

    }else{

    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView removeAnnotations:self.annotations];
    
    [self.mapView viewWillDisappear];
    
    self.mapView.delegate = nil; // 不用时，置nil
    
    self.mapView = nil;
    
    [self.selectVC.view removeFromSuperview];
    self.selectVC = nil;
    
    [self.selectMoreVC.view removeFromSuperview];
    self.selectMoreVC = nil;
    
    [self.selectLocationVC.view removeFromSuperview];
    self.selectLocationVC = nil;
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

- (IBAction)btnChangeLocationClick:(id)sender {
    [self.searchFiled resignFirstResponder];
    
    self.selectLocationVC.view.hidden = YES;
    
    [self.selectLocationVC.view removeFromSuperview];
    self.selectLocationVC = nil;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    self.selectLocationVC.view.hidden = NO;
    
    NDRoomSelectLocationVC *selectLocationVC = [NDRoomSelectLocationVC new];
    selectLocationVC.view.width = _mapView.width;
    selectLocationVC.view.height = _mapView.height;
    selectLocationVC.view.top = self.topView.bottom;
    selectLocationVC.parentVC = self;
    [self.view addSubview:selectLocationVC.view];
//    selectLocationVC.view.hidden = YES;
    self.selectLocationVC = selectLocationVC;
}

- (void)dealloc{
    [self.mapView removeFromSuperview];
    self.mapView.delegate = nil; // 不用时，置nil
    self.mapView = nil;
    
    [self.selectVC.view removeFromSuperview];
    self.selectVC = nil;
    
    [self.selectMoreVC.view removeFromSuperview];
    self.selectMoreVC = nil;
    
    [self.selectLocationVC.view removeFromSuperview];
    self.selectLocationVC = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
