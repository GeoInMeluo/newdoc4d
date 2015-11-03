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
#import "NDPointAnnotation.h"
#import "NDRoomDetailVC.h"

#define kRoomMapChangeSearchFieldText @"roomMapChangeSearchFieldText"

@interface NDRoomMapVC ()

@property (nonatomic, weak) IBOutlet BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService *loactionService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;

@property (nonatomic, strong) NDRoomSelectVC *selectVC;
@property (nonatomic, strong) NDRoomSelectMoreVC *selectMoreVC;
@property (nonatomic, strong) NDRoomSelectLocationVC *selectLocationVC;
@property (weak, nonatomic) IBOutlet UIView *searchDiv;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (nonatomic, assign) BOOL currentMap;
@property (weak, nonatomic) UIView *slider;
@property (nonatomic, strong) NSMutableArray *annotations;
//@property (nonatomic, assign) BMKUserLocation *userlocation;
@property (nonatomic, strong) NSArray *rooms;

@property (nonatomic, assign) CLLocationCoordinate2D lastLocation;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (nonatomic, weak) UIButton *btnNavRight;




@end

@implementation NDRoomMapVC

- (NSArray *)rooms{
    if(_rooms == nil){
        _rooms = [NSArray array];
    }
    return _rooms;
}

- (NSMutableArray *)annotations{
    if(_annotations == nil){
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

//- (NDRoomSelectLocationVC *)selectLocationVC{
//    if(_selectLocationVC == nil){
//        WEAK_SELF;
//        
//        NDRoomSelectLocationVC *selectLocationVC = [NDRoomSelectLocationVC new];
//        selectLocationVC.view.width = _mapView.width;
//        selectLocationVC.view.height = _mapView.height;
//        selectLocationVC.view.top = self.topView.bottom;
//        selectLocationVC.parentVC = self;
//        
//        __weak typeof(selectLocationVC) weakSelectionVC = selectLocationVC;
//        //选择完地点后进行的操作
//        selectLocationVC.countyCellCallback = ^(){
//            weakself.mapView.hidden = NO;
//            BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//            geocodeSearchOption.city = weakSelectionVC.cityName;
//            geocodeSearchOption.address = weakSelectionVC.countyName;
//            BOOL flag = [weakself.geoSearch geoCode:geocodeSearchOption];
//            if(flag)
//            {
//                NSLog(@"geo检索发送成功");
//            }
//            else
//            {
//                NSLog(@"geo检索发送失败");
//            }
//        };
//        [self.view addSubview:selectLocationVC.view];
//        _selectLocationVC = selectLocationVC;
//    }
//    return _selectLocationVC;
//}

//- (NDRoomSelectVC *)selectVC{
//    if(_selectVC == nil){
//        NDRoomSelectVC *selectVC = [NDRoomSelectVC new];
//        selectVC.tableView.width = _mapView.width;
//        selectVC.tableView.height = _mapView.height - self.segmentView.height;
//        selectVC.tableView.top = self.segmentView.bottom;
//        [self.view addSubview:selectVC.tableView];
//        selectVC.view.hidden = self.currentMap;
//        selectVC.parentVC = self;
//        _selectVC = selectVC;
//    }
//    return _selectVC;
//}

//- (NDRoomSelectMoreVC *)selectMoreVC{
//    if(_selectMoreVC == nil){
//        NDRoomSelectMoreVC *selectMoreVC = [NDRoomSelectMoreVC new];
//        selectMoreVC.view.width = _mapView.width;
//        selectMoreVC.view.height = _mapView.height - self.segmentView.height;
//        selectMoreVC.view.top = self.segmentView.bottom;
//        [self.view addSubview:selectMoreVC.view];
//        selectMoreVC.view.hidden = YES;
//        selectMoreVC.parentVC = self;
//        _selectMoreVC = selectMoreVC;
//    }
//    return _selectMoreVC;
//}

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
    self.btnNavRight = button;
    button.enabled = NO;
    
    self.searchDiv.layer.cornerRadius = 5;
    self.searchDiv.layer.masksToBounds = YES;
    
    UIView *slider = [[UIView alloc] init];
    self.slider = slider;
    [self.segmentView addSubview:slider];
    
    self.segmentView.hidden = self.currentMap;
    [self.view addSubview:self.segmentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSearchFieldText:) name:kRoomMapChangeSearchFieldText object:nil];
    
    BMKLocationService *locService = [[BMKLocationService alloc]init];
    self.loactionService = locService;
    
    BMKGeoCodeSearch *geoSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoSearch = geoSearch;
    
    
    NDRoomSelectMoreVC *selectMoreVC = [NDRoomSelectMoreVC new];
    _selectMoreVC = selectMoreVC;
    _selectMoreVC.view.hidden = YES;
    [self.view addSubview:selectMoreVC.view];
    
    NDRoomSelectLocationVC *selectLocationVC = [NDRoomSelectLocationVC new];
    _selectLocationVC = selectLocationVC;
    _selectLocationVC.view.hidden = YES;
    [self.view addSubview:selectLocationVC.view];
    
    NDRoomSelectVC *selectVC = [NDRoomSelectVC new];
    _selectVC = selectVC;
    _selectVC.tableView.hidden = YES;
    [self.view addSubview:selectVC.tableView];
    
    
}

- (void)changeSearchFieldText:(NSNotification *)notification{
    [self.btnSearch setTitle:self.selectLocationVC.area forState:UIControlStateNormal] ;
}

- (void)startGetRoomsWithLocation:(CLLocationCoordinate2D)coordinate andCityName:(NSString *)cityName andCountyName:(NSString *)countyName {
    [self startGetRoomListWithLocation:coordinate andCityName:cityName andAreaName:countyName success:^(NSArray *rooms) {
        WEAK_SELF;
        
        if(rooms.count != 0){
//            NDRoom *room1 = [NDRoom new];
//            room1.latitude = @"39.92";
//            room1.longitude = @"116.42";
//            room1.name = @"test1";
//            
//            NDRoom *room2 = [NDRoom new];
//            room2.latitude = @"39.81";
//            room2.longitude = @"116.41";
//            room2.name = @"test2";
//            
//            NDRoom *room3 = [NDRoom new];
//            room3.latitude = @"39.73";
//            room3.longitude = @"116.43";
//            room3.name = @"test3";
//            
//            self.rooms = @[room1,room2,room3];
            weakself.rooms = rooms;
        
            [weakself addRoomAnnotations];
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.selectMoreVC.rooms = weakself.rooms;
                [weakself.selectMoreVC.leftTable reloadData];
                
                weakself.selectVC.rooms = weakself.rooms;
                [weakself.selectVC.tableView reloadData];
            });
            
            weakself.btnNavRight.enabled = YES;
        }
    } failure:^(NSDictionary *result, NSError *error) {
        
    }];
}

- (void)addRoomAnnotations{
    for (NDRoom *room in self.rooms) {
        //     添加一个PointAnnotation
        NDPointAnnotation* annotation = [[NDPointAnnotation alloc]init];
//        annotation.coordinate = self.loactionService.userLocation.location.coordinate;
        
        annotation.coordinate = CLLocationCoordinate2DMake([room.latitude doubleValue], [room.longitude doubleValue]);
        annotation.title = room.name;
        annotation.room = room;
        
        [self.mapView addAnnotation:annotation];
        [self.annotations addObject:annotation];
    }
    
//    [self.mapView mapForceRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.mapView viewWillAppear];
    
    self.mapView.delegate = self;
    
    self.loactionService.delegate = self;
    
    self.geoSearch.delegate = self;
    
    //启动LocationService
    [self.loactionService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
//    [self.mapView selectAnnotation:annotation animated:YES];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
     WEAK_SELF;
    
    self.segmentView.hidden = YES;
    self.segmentView.top = self.topView.bottom;
    self.segmentView.width = self.view.width;
    
    
    _selectMoreVC.view.width = _mapView.width;
    _selectMoreVC.view.height = _mapView.height - self.segmentView.height;
    _selectMoreVC.view.top = self.segmentView.bottom;
    _selectMoreVC.view.hidden = YES;
    _selectMoreVC.parentVC = self;
    
    _selectLocationVC.view.hidden = YES;
    _selectLocationVC.view.width = _mapView.width;
    _selectLocationVC.view.height = _mapView.height;
    _selectLocationVC.view.top = self.topView.bottom;
    _selectLocationVC.view.hidden = self.currentMap;
    _selectLocationVC.parentVC = self;
    __weak typeof(_selectLocationVC) weakSelectionVC = _selectLocationVC;
    //选择完地点后进行的操作
    _selectLocationVC.countyCellCallback = ^(){
        weakself.mapView.hidden = NO;
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geocodeSearchOption.city = weakSelectionVC.cityName;
        geocodeSearchOption.address = weakSelectionVC.countyName;
        BOOL flag = [weakself.geoSearch geoCode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
    };
    
    
    
    _selectVC.tableView.width = _mapView.width;
    _selectVC.tableView.height = _mapView.height - self.segmentView.height;
    _selectVC.tableView.top = self.segmentView.bottom;
    _selectVC.tableView.hidden = self.currentMap;
    _selectVC.parentVC = self;
    _selectVC.rooms = self.rooms;
    
    [self.mapView.superview bringSubviewToFront:self.mapView];
    self.mapView.hidden = NO;
    
    self.slider.frame = CGRectMake(0, self.segmentView.height - 2, self.segmentView.width * 0.4, 2);
    self.slider.backgroundColor = Blue;
    self.slider.centerX = kScreenSize.width * 0.75;
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{

}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_mapView updateLocationData:userLocation];
//    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
//    if(CLLocationCoordinate2DIsValid(self.lastLocation)){
    if (self.rooms.count == 0) {

        self.lastLocation = userLocation.location.coordinate;

        BMKReverseGeoCodeOption *geoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
        geoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
        
        [self.geoSearch reverseGeoCode:geoCodeOption];
        
        [self.mapView setCenterCoordinate:self.lastLocation];
        
        [self.mapView setZoomLevel:14];
        
//        if(self.selectVC){
//            [self.selectVC.tableView reloadData];
//        }
        
        [self.loactionService stopUserLocationService];
    }
}

//反向地理编码(进入地图时，根据地图定位位置得到地点名称，查询诊室列表)
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    self.lastLocation = result.location;
    
    [self startGetRoomsWithLocation:self.lastLocation andCityName:result.addressDetail.city andCountyName:result.addressDetail.district];
}

//正向地理编码(选择完位置后，根据选择的地点名称得到位置，查询诊室列表)
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    self.lastLocation = result.location;
    
    [self.mapView removeAnnotations:self.annotations];
    
    [self.mapView setCenterCoordinate:result.location];
    
    [self.mapView setZoomLevel:14];
    
    [self startGetRoomsWithLocation:self.lastLocation andCityName:self.selectLocationVC.cityName andCountyName:self.selectLocationVC.countyName];
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    WEAK_SELF;
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NDPointAnnotation *pA = (NDPointAnnotation *)annotation;

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
        pop.lblTitle.text = pA.room.name;
        pop.lblLocation.text = pA.room.address;
        pop.btnRoomDetail.callback = ^(Button *btn){
            NDRoomDetailVC *vc = [NDRoomDetailVC new];
            vc.room = pA.room;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        pop.btnPhoneNumber.callback = ^(Button *btn){
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",btn.titleLabel.text];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        };
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

////百度定位获取经纬度信息
//-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
//    NSLog(@"!latitude!!!  %f",userLocation.location.coordinate.latitude);//获取经度
//    NSLog(@"!longtitude!!!  %f",userLocation.location.coordinate.longitude);//获取纬度
//    CLLocationDegrees localLatitude=userLocation.location.coordinate.latitude;//把获取的地理信息记录下来
//    CLLocationDegrees localLongitude=userLocation.location.coordinate.longitude;
//    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
//    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
//        for (CLPlacemark *placemark in place) {
//            NSString * cityStr=placemark.thoroughfare;
//            NSString * cityName=placemark.locality;
//            NSLog(@"city %@",cityStr);//获取街道地址
//            NSLog(@"cityName %@",cityName);//获取城市名
//            break;
//        }
//    };
//    CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
//    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
//}

- (void)rightBtnClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    self.currentMap = !self.currentMap;
    self.mapView.hidden = !self.currentMap;
//    self.selectMoreVC.view.hidden = self.currentMap;
    self.selectVC.tableView.hidden = self.currentMap;
    self.segmentView.hidden = self.currentMap;
    [self.segmentView.superview bringSubviewToFront:self.segmentView];
//    self.selectLocationVC.view.hidden = YES;
    
    if(!self.selectVC.tableView.hidden){
        self.selectMoreVC.view.hidden = YES;
        self.selectLocationVC.view.hidden = YES;
        self.slider.centerX = self.view.width * 0.75;
    }else{
        self.slider.centerX = self.view.width * 0.25;
    }
    
//    if(!self.selectMoreVC.view.hidden){
//        self.selectMoreVC.view.hidden = YES;
//        self.selectLocationVC.view.hidden = YES;
//    }
//    
//    if(!self.selectLocationVC.view.hidden){
//        self.selectMoreVC.view.hidden = YES;
//        self.selectLocationVC.view.hidden = YES;
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [self.loactionService stopUserLocationService];
    
    [self.mapView removeAnnotations:self.annotations];
    
    [self.mapView viewWillDisappear];
    
    self.mapView.delegate = nil; // 不用时，置nil
    self.loactionService.delegate = nil;
    self.geoSearch.delegate = nil;
    
//    [self.selectVC.tableView removeFromSuperview];
//    self.selectVC = nil;
    
//    [self.selectMoreVC.view removeFromSuperview];
//    self.selectMoreVC = nil;
    
//    [self.selectLocationVC.view removeFromSuperview];
//    self.selectLocationVC = nil;
}


- (IBAction)leftSegClicked:(UIButton *)sender {
    WEAK_SELF;
    
    self.selectVC.tableView.hidden = YES;
    self.selectMoreVC.view.hidden = NO;
    self.selectLocationVC.view.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakself.slider.centerX = weakself.view.width * 0.25;
    }];
}

- (IBAction)rightSegClicked:(UIButton *)sender {
    WEAK_SELF;
    
    self.selectVC.tableView.hidden = NO;
    self.selectMoreVC.view.hidden = YES;
    self.selectLocationVC.view.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakself.slider.centerX = weakself.view.width * 0.75;
    }];
}

- (IBAction)btnChangeLocationClick:(id)sender {
    self.selectLocationVC.view.hidden = YES;
}


- (IBAction)btnSearchClicked:(id)sender {
    self.selectLocationVC.view.hidden = NO;
    [self.view bringSubviewToFront:self.selectLocationVC.view];
}

- (void)dealloc{
    [self.mapView removeFromSuperview];
    self.mapView.delegate = nil; // 不用时，置nil
    self.mapView = nil;
    
    self.loactionService.delegate = nil;
    self.loactionService = nil;
    
    _geoSearch.delegate = nil;
    _geoSearch = nil;
    
    [_selectVC.tableView removeFromSuperview];
    _selectVC = nil;
    
    [_selectMoreVC.view removeFromSuperview];
    _selectMoreVC = nil;
    
    [_selectLocationVC.view removeFromSuperview];
    _selectLocationVC = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
